From: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH][v3] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Mon, 10 Sep 2012 02:53:35 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079D9AB9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
 <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bhartiya Anju-B07263 <B07263@freescale.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> > +	/* Workaround for data length mismatch errata */
> > +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> > +			qc = ata_qc_from_tag(ap, tag);
> > +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> > +				u32 hcontrol;
> > +#define HCONTROL_CLEAR_ERROR	(1 << 27)
> 
> shouldn't we have this #define be part of the enum that the other
> HCONTROL_ bits/flags are part of?
[S.H] do you mean this?

#ifdef SATA_FSL_XXX_ERRATUAM
#define HCONTROL_CLEAR_ERROR	(1 << 27)
#endif

Then we need to decide where to put "#define SATA_FSL_XXX_ERRATUAM".

It's only a readable definition of a register bit which avoiding magic number.


Best Regards, 
Shaohui Xie
