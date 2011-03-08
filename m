From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH][v2] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Tue, 8 Mar 2011 11:39:02 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC6E@saturn3.aculab.com>
References: <1299555095-2967-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-class: urn:content-classes:message
In-Reply-To: <1299555095-2967-1-git-send-email-prabhakar@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Prabhakar Kushwaha <prabhakar@freescale.com>, linux-ide@vger.kernel.org
Cc: meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>, jgarzik@pobox.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

 
>  Case when ffs return will never arise.This scenario is 
> already been discussed
>  on linuxppc-dev@lists.ozlabs.org. Please see below explanation:
>  sata_fsl_error_intr() is called during device error.The 
> mentioned scenario
>  will never comes. It can be observed via code:-
>         if (cereg) {   --> cereg is set on command error. 
> Means there is at least 1 device present.

This all relies on the hardware working properly, and
nothing else accidentally clearing the device 'error'
bit mask.

Being slightly defensive when the out of range value
causes an array subscript error seems sensible.

It isn't as though the code size or execution time
matters here.

	David
