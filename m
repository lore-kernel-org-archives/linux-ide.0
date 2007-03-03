From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Sat, 3 Mar 2007 00:54:33 +0000
Message-ID: <20070303005433.714d75ad@lxorguk.ukuu.org.uk>
References: <45DA44B4.6000209@shaw.ca>
	<45E8B42E.7010900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992775AbXCBXua@vger.kernel.org>
In-Reply-To: <45E8B42E.7010900@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

> it seems broken to manipulate xfer_mask after returning from the 
> driver's ->mode_filter hook.
> 
> this patch is more than just a speed-limited warning printk, afaics

I actually suggested that order because the only way the printk can be
done correctly is for it to be the very last test made. Since the mode
filter is not told what mode will be used but just subtracts modes that
are not allowed this should be safe.

I don't otherwise see how we deal with the case where a 40wire cable is
used and the mode filter function decides itself to drop to UDMA33 or
lower due to incompatibilities or errata.

Alan
