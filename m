From: Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Thu, 16 Apr 2009 16:27:59 -0500
Message-ID: <ed82fe3e0904161427y4d4e7f4ewcf39956ab82d4de9@mail.gmail.com>
References: <49DB6914.1030107@freescale.com> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
	<1239234793.6214.5.camel@localhost>
	<E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
	<1239251928.22777.2.camel@localhost> <49DD8871.2030404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <49DD8871.2030404@garzik.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 9, 2009 at 12:32 AM, Jeff Garzik <jeff@garzik.org> wrote:

> 3) As a result, Timur's 'ahci' is no longer receiving interrupts. Presuma=
bly
> this means that BOTH of the following conditions are true
>
> =A0 =A0 =A0 =A0a) INTX is disabled
> =A0 =A0 =A0 =A0b) MSI is not available
>
> Today I am thinking we should either revert the libata commit
> (a5bfc4714b3f01365aef89a92673f2ceb1ccf246), or poke PCI to twiddle INTX f=
or
> us at pci_enable_device() time, perhaps.

We (Freescale) have discussed and debugged this issue, and I'm 99%
certain that we have a board-specific fix, so there's no need to
revert the patch.

According to the original developer, he had to disable the INTX on the
board if SATA were disabled, otherwise some other problem occurred.
He noticed that the interrupt was re-enabled (presumably by the
pre-patch code in ahci.c), so he thought it would be okay to disable
it.

I've run some tests, and so far it appears that the problem does not
occur with the latest kernel (or the latest revision of the hardware).
 I need to run some more tests to be absolutely certain.  If those
tests pass, then I will post a patch that modifies
hpcd_quirk_uli5288().

So please, don't revert any patches.  And thanks to everyone for
helping me resolve this issue.

-- =

Timur Tabi
Linux kernel developer at Freescale
