From: Tejun Heo <htejun@gmail.com>
Subject: Re: problems with packet command
Date: Mon, 10 Dec 2007 16:54:10 +0900
Message-ID: <475CF0A2.1050208@gmail.com>
References: <743310.96837.qm@web35412.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:31667 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXLJHyV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 02:54:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3195304wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 23:54:20 -0800 (PST)
In-Reply-To: <743310.96837.qm@web35412.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kantor Zsolt <kantorzsolt@yahoo.com>
Cc: linux-ide@vger.kernel.org

Kantor Zsolt wrote:
> Hi, I'm developing an application that uses cd-rom IOCTL's. All is
> fine but I have one problem I can not set up a packet command,
> because I don't know exactly how to fill out the 12 byte command 
> field.  I searched the internet, looked in the cdrom.c driver, some
> other programs source code, but I don't have a clear picture about
> that. I just know that the first element cmd[0] is the command.
>
> Would somebody please explain me how to fill out the 12 bytes ? or if
> not then at least could point out a good online resource. You are my
> last hope

That field contains SCSI CDBs which are described in SCSI standards.
You can download standard drafts from t10.org freely and drafts are as
good as the real ones.  You'll need to look at SPC and MMC standards.

-- 
tejun
