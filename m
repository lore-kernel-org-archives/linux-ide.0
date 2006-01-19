From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 16:29:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org>
References: <200601192059.40161.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:31929 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161434AbWASV3G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 16:29:06 -0500
In-Reply-To: <200601192059.40161.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Rene Herman <rene.herman@keyaccess.nl>

On Thu, 19 Jan 2006, Helmut Toplitzer wrote:

> Is this adequate?
> You need a VIA82xxx board, HLT and pass disableviahlt on boot.
> Tested on my system with success. Please check for 
> errors.

Some stylistic suggestions.  The new routines should be surrounded by

#if defined(CONFIG_BLK_DEV_VIA82CXXX) and defined(HAVE_VIA_HALT)

In the #else part, make ide_disable_hlt and ide_enable_hlt inline.

You don't need the #ifdef protecting the calls to to ide_disable_hlt and 
ide_enable_hlt.

Alan Stern

