From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
Date: Mon, 17 May 2010 12:06:47 +0200
Message-ID: <201005171206.47566.sr@denx.de>
References: <201005051757.o45HvPmY005954@amcc.com>
	<4BED8BF1.5080800@ru.mvista.com>
	<1273966828.21352.670.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1273966828.21352.670.camel@pasglop>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Rupjyoti Sarmah <rsarmah@amcc.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hi Ben,

On Sunday 16 May 2010 01:40:28 Benjamin Herrenschmidt wrote:
> > > +		SATA0: sata@bffd1000 {
> > > +                        compatible = "amcc,sata-460ex";
> > > +			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
> > > +                        interrupt-parent = <&UIC3>;
> > > +                        interrupts = <0x0 0x4       /* SATA */
> > > +                                      0x5 0x4>;     /* AHBDMA */
> > > +                };
> > > +
> > > 
> > >  		POB0: opb {
> > >  		
> > >  			compatible = "ibm,opb-460ex", "ibm,opb";
> > >  			#address-cells = <1>;
> >    
> >    Please put the device tree update in a separate patch to go thru the
> > 
> > PowerPC tree.
> 
> Additionally, the boot wrapper should probably either remove the node or
> at least use a status property "ok" / "disabled" to represent whether
> the board is configured for SATA or PCIe x1...

U-Boot already sets the "status" property of the PCIe or SATA node 
accordingly. Just let me know if this doesn't work for you.

Cheers,
Stefan
