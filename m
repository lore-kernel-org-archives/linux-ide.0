From: <v.virvilis@biovista.com>
Subject: Re: SATA disks resets in a md setup
Date: Sat, 09 May 2009 12:41:05 -0400
Message-ID: <3794dbcf42f7f6b00e50070eeb203e8b@biovista.com>
References: <200905081739.46206.v.virvilis@biovista.com> <4A053229.5010406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753219AbZEIQlU@vger.kernel.org>
In-Reply-To: <4A053229.5010406@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sat, 09 May 2009 03:35:05 -0400, Jeff Garzik <jeff@garzik.org> wrote:

> 
> For hardware details, see 
> http://ata.wiki.kernel.org/index.php/Libata_error_messages

Thanks for the link.
> 
> The ATA bus is the cable connection, so an ATA bus error typically means
> 
> - problem with your cable, or
> - your motherboard's SATA port, or
> - your drive's SATA port, or
> - "dirty power" supply, or
> - some other cause for cable interference
> 

I have changed SATA cables twice and I added a better PSU. The problem
persists.

Do you have any insight on the sectors count mismatch I mentioned in the
first mail?
The disk is 250GB but it looks it is searching for a 500GB disk (that is
md0 = sda + sdb).

Is it possible the SATA reset thing to trigger an md bug. I am totally
guessing here...

Regards
            .bill
