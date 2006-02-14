From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of
	32-bit operations
Date: Tue, 14 Feb 2006 16:50:28 +0000
Message-ID: <1139935828.10394.44.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422646AbWBNQrl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2006-02-14 at 10:22 -0600, Kumar Gala wrote:
> In some embedded systems the IDE hardware interface may only support 16-bit
> or smaller accesses.  Allow the interface to specify if this is the case
> and don't allow the drive or user to override the setting.

The "no_io_32bit" is just a dead leftover. It has no effect at all
anyway so this patch is a bit pointless.



Do a grep over the code for no_io_32bit and you will see its essentially
a private variable in the CMD640 driver.
