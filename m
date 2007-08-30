From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Thu, 30 Aug 2007 17:16:46 -0400
Message-ID: <87f94c370708301416j2a7c000bscbaef593af004010@mail.gmail.com>
References: <200708212149.12912.jopan@alumni.uv.es>
	 <20070822162312.GG9412@csclub.uwaterloo.ca>
	 <46CC6A2F.5000406@gmail.com> <200708280044.34475.jopan@alumni.uv.es>
	 <46D455DB.8000800@gmail.com>
	 <Pine.LNX.4.64.0708302130210.24730@fbirervta.pbzchgretzou.qr>
	 <46D7231B.3080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762517AbXH3VRA@vger.kernel.org>
In-Reply-To: <46D7231B.3080807@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, =?ISO-8859-1?Q?Jos=E9_Luis_Pati=F1o_Andr=E9s?= <jopan@alumni.uv.es>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 8/30/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 08/30/2007 09:31 PM, Jan Engelhardt wrote:
>
> > On Aug 28 2007 19:05, Rene Herman wrote:
>
> >> Sheesh. How could anyone _not_ understand you need SCSI CD-ROM support
> >> for your IDE DVD-RW drive...
> >
> > Welcome to the wonderful world of SCSIfying ATA. (Don't talk about ATAPI,
> > USB/Firewire, it's a different matter.)
>
> Well -- the world where ATA, SCSI, USB, Firewire and what have you are
> low-level drivers to a unifying storage layer is under non too obscure
> definitions sort of not non-wonderful...
>

USB / Firewire / FC / iSCSI are all SCSI transports and fit within the
SCSI subsystem by design.

ie. Just like ethernet, DSL, T-1, etc can all carry IP traffic with no
conceptual conflict, many media by design carry SCSI traffic.

The PATA and SATA physical layer typically carry ATA commands and
having them tied into the SCSI stack is an aberration that I hope will
be eliminated some day.

ATAPI is an exception.  Not sure where that would end up in a perfect world.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
