From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 23:38:30 +0000
Message-ID: <1131493110.25192.112.camel@localhost.localdomain>
References: <1131471483.25192.76.camel@localhost.localdomain>
	 <pan.2005.11.08.19.02.09.190896@sci.fi>
	 <1131480140.25192.98.camel@localhost.localdomain>  <43712830.90805@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030400AbVKHXHo@vger.kernel.org>
In-Reply-To: <43712830.90805@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-11-08 at 17:35 -0500, Bill Davidsen wrote:
> May we assume that this information was gathered in the interest of 
> something beyond pedantic curiousity? Will this simplify the driver 
> code, improve performance or reliability, etc?

Something like that

I've been collecting the data to get the libata driver right, and in
doing so even with the partial data I had came across some chunks of
data that are wrong in the ide/pci driver.

Its not made easier by the fact hpt seem to have taken down their own
drivers for older (now "unsupported" I suspect) chips.

The frequency and chip id data is needed to correctly tune the PLLs and
to identify the right base frequency for timing.
