From: "Paresh Sawant" <p.Sawant@zensar.com>
Subject: WIN_READDMA
Date: Fri, 6 Dec 2002 10:39:36 +0530
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <54670264D99F034EA23CBB7D7A45AE7E774C@zenmail1.ind.zensar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from scanmail.zensar.com (smtpfw.zensar.com [202.54.40.195])
	by omega.zensar.com (8.9.3+Sun/8.9.3) with SMTP id KAA04916
	for <linux-ide@vger.kernel.org>; Fri, 6 Dec 2002 10:43:55 -0500 (GMT)
content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi
    i want to send  "WIN_READDMA" ATA command to ide hard drive, i am doing ioctl call using command HDIO_DRIVE_TASK, what would be the third argument to the ioctl call ? currently i m passing following as third arg -
unsigned char args[8+512] = {WIN_READDMA,feature,sector_count,low_lba,mid_lba,high_lba,device,};

thanks
paresh
