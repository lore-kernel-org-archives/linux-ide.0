From: "Aurelien B." <kerusursaone@gmail.com>
Subject: ide-scsi problems
Date: Tue, 24 May 2005 16:38:38 +0200
Message-ID: <187e0cd605052407383eb425b1@mail.gmail.com>
Reply-To: "Aurelien B." <kerusursaone@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:15233 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbVEXOij convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 May 2005 10:38:39 -0400
Received: by wproxy.gmail.com with SMTP id 68so267681wra
        for <linux-ide@vger.kernel.org>; Tue, 24 May 2005 07:38:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
maybe im on the wrong, i dont really know if i can find help here.
i compiled the 2.6.12-rc4, everything works fine, and i tried ide-scsi
module to get better dvd burning speed.
it works, i get 5x transfer, but once its finished, the dvd burner is
no longer recognized and doesnt want to eject, i have to reboot to get
it work again.
without ide-scsi, i only have a 1x burning speed and the dvd can eject
and burn another one without pb.
