From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: revert request "ide: skip probe if there are no devices on the port (v2)"
Date: Sun, 28 Mar 2010 23:37:01 +0200
Message-ID: <201003282337.01747.bzolnier@gmail.com>
References: <20100328212728.GA2674@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:34830 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab0C1Vhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 17:37:32 -0400
In-Reply-To: <20100328212728.GA2674@spacedout.fries.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Fries <david@fries.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 28 March 2010 11:27:28 pm David Fries wrote:
> Now that I have 2.6.34-rc2 booting it no longer detects the cdrom
> drive.  That is looking at the kernel messages, partition dump, and
> after booting hdparm etc does not find the drive.  I expect it is
> because the cdrom is a slave drive without a master on that ribbon.
> Reverting
> -------------------------------
> commit a20b2a44eca52818ef52a94959480b7e6ea2f528
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Mon Jun 8 22:07:28 2009 +0200

It was reported to upstream maintainer on 2009-10-18.

https://bugzilla.kernel.org/show_bug.cgi?id=14438

PS Please do not cc: me on upstream kernel problems, I don't have any
time to work on them (maintainer change happened on Jun 21 2009)..

--
Bartlomiej Zolnierkiewicz
