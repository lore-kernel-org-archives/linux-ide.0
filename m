From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Oops in pata_pdc2027x
Date: Wed, 06 Dec 2006 14:10:15 +0800
Message-ID: <45765EC7.2000908@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760235AbWLFGKg@vger.kernel.org>
In-Reply-To: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: linux-ide@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> I get an oops during initialisation of the pata_pdc2027x module on a
> POWER 285 machine.  This is on a very recent Linus kernel tree
> (ff51a98799931256b555446b2f5675db08de6229) with Paulus' powerpc tree
> (that has now been merged). The oops looks like this:
> 

Hi Stephen,

Where could I download the patched kernel source? There are two
POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
on these boxes.

--
albert
