From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
Date: Sat, 12 Nov 2005 18:03:34 +0000
Message-ID: <1131818615.18258.6.camel@localhost.localdomain>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932429AbVKLRch@vger.kernel.org>
In-Reply-To: <20051112165548.GB28987@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sad, 2005-11-12 at 16:55 +0000, Russell King wrote:
> We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
> chipsets where the southbridge revision is <= 5, otherwise data
> corruption will occur.


If you are fixing this driver also set ->serialize = 1; before someone
with dual channel device gets burned.
