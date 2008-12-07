From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 1/2] sgiioc4: kill useless address checks
Date: Sun, 7 Dec 2008 00:03:51 -0800
Message-ID: <20081207080351.GA332982@sgi.com>
References: <200810152329.20095.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:52089 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752830AbYLGID5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2008 03:03:57 -0500
Content-Disposition: inline
In-Reply-To: <200810152329.20095.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Wed, Oct 15, 2008 at 11:29:19PM +0400, Sergei Shtylyov wrote:
> - in sgiioc4_read_status(), we always read the IDE status register, so there's
>   no need to check the register's address (must be a leftover from the times
>   when this function implemented the INB() method);

Correct.  That code was left over from this:

static u8
sgiioc4_INB(unsigned long port)
{
        u8 reg = (u8) inb(port);

        if ((port & 0xFFF) == 0x11C) {  /* Status register of IOC4 */
                if (reg & 0x51) {       /* Not busy...check for interrupt */
                        unsigned long other_ir = port - 0x110;
                        unsigned int intr_reg = (u32) inl(other_ir);

                        /* Clear the Interrupt, Error bits on the IOC4 */
                        if (intr_reg & 0x03) {
                                outl(0x03, other_ir);
                                intr_reg = (u32) inl(other_ir);
                        }
                }
        }

        return reg;     
}

Thanks for the cleanup.

jeremy
