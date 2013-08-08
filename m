From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Thu, 8 Aug 2013 11:58:08 -0700
Message-ID: <CAO1A-8DqjSAZ=GD6_BxxaBxvbsbYTUuPZSc-odr=bikUk3FtAg@mail.gmail.com>
References: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com>
	<1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
	<5203DAD0.6040604@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:51932 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966076Ab3HHS6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 14:58:09 -0400
Received: by mail-ve0-f174.google.com with SMTP id d10so3338640vea.5
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 11:58:08 -0700 (PDT)
In-Reply-To: <5203DAD0.6040604@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello Sergei,

>    How about non-AHCI FIS-based controllers?
Right. Since it's cost prohibitive for me to test exhaustively on
non-AHCI FIS-based controllers, do you think it would be acceptable to
add a new ATA host flag... something like, ATA_FLAG_AHCI, which would
denote the controller as being AHCI-based? Then the flag could be used
to gate processing of READ/WRITE/SEND/RECEIVE FPDMA commands that have
the 'auxiliary' field set. Or, I could add a big fat warning print
whenever an ata_queued_cmd is passed to the drivers with a non-zero
'auxiliary' value.

Regards,
Marc
