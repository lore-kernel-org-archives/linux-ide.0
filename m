From: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH][v3] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Mon, 10 Sep 2012 10:45:37 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079D9FCF@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
 <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
 <ED492CCEAF882048BC2237DE806547C9079D9AB9@039-SN2MPN1-012.039d.mgd.msft.net>
 <504DBF3D.2000102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <504DBF3D.2000102@mvista.com>
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
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bhartiya Anju-B07263 <B07263@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-ide@vger.kernel.org

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Monday, September 10, 2012 6:22 PM
> To: Xie Shaohui-B21989
> Cc: Kumar Gala; jgarzik@pobox.com; linux-ide@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Bhartiya Anju-B07263
> Subject: Re: [PATCH][v3] sata_fsl: add workaround for data length
> mismatch on freescale V2 controller
> 
> Hello.
> 
> On 10-09-2012 6:53, Xie Shaohui-B21989 wrote:
> 
> >>> +	/* Workaround for data length mismatch errata */
> >>> +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> >>> +		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> >>> +			qc = ata_qc_from_tag(ap, tag);
> >>> +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> >>> +				u32 hcontrol;
> >>> +#define HCONTROL_CLEAR_ERROR	(1 << 27)
> 
> >> shouldn't we have this #define be part of the enum that the other
> >> HCONTROL_ bits/flags are part of?
> 
> > [S.H] do you mean this?
> 
>     Apparently not. He said *enum*, not #define.

[S.H] OK. Thank you for the clarification.


Best Regards, 
Shaohui Xie
