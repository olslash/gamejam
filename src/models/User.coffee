module.exports = (sequelize, DataTypes) ->
  sequelize.define('User', {
    username:
      type: DataTypes.STRING
      unique: true
      allowNull: false
      validate:
        isAlphanumeric: true
    email:
      type: DataTypes.STRING
      unique: true
      allowNull: false
      validate:
        isEmail: true
    website:
      type: DataTypes.STRING
      validate:
        isUrl: true
    about: DataTypes.TEXT
    avatar:
      type: DataTypes.STRING
      validate:
        isUrl: true
    sa_id:
      type: DataTypes.INTEGER
      unique: 'compositeIndex'
    sa_username:
      type: DataTypes.STRING
      unique: 'compositeIndex'
    twitch_username: DataTypes.STRING
  },

  {
    underscored: true
  },

  {
    classMethods:
      associate: (models) ->
        # User.hasMany(models.Vote)
        User.hasMany(models.Project)
        User.hasMany(models.Jam, {as: 'Judging', through: 'user_judging'})
  })
