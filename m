From: "Paresh Sawant" <p.Sawant@zensar.com>
Subject: struct to be passed to ioctl call for commanf HDIO_DRIVE_CMD
Date: Wed, 4 Dec 2002 14:40:21 +0530
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <54670264D99F034EA23CBB7D7A45AE7E5ECE@zenmail1.ind.zensar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from scanmail.zensar.com (smtpfw.zensar.com [202.54.40.195])
	by omega.zensar.com (8.9.3+Sun/8.9.3) with SMTP id OAA19799
	for <linux-ide@vger.kernel.org>; Wed, 4 Dec 2002 14:44:56 -0500 (GMT)
content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi 

	I want to send ATA command to IDE hard disk driver using ioctl with comand "HDIO_DRIVE_CMD", to do raw write to hard disk. Which Struct i should pass to ioctl call as a third argument ?

Thanks 
paresh
