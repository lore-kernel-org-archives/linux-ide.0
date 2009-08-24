From: Jurij Smakov <jurij@wooyd.org>
Subject: Re: Sun Blade 100 - boot issue
Date: Mon, 24 Aug 2009 19:36:17 +0100
Message-ID: <20090824183616.GA5492@droopy.oc.cox.net>
References: <9a65e4710908220341j75457e31m475da871cbb266fd@mail.gmail.com>
 <4A924AAB.8070408@ed.ac.uk>
 <20090824103607.GA14812@orion.carnet.hr>
 <20090824145754.6d5a63a2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-sparc=debian-sparc=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <20090824145754.6d5a63a2@lxorguk.ukuu.org.uk>
Resent-Message-ID: <eXH69XCRRlE.A.MWE.22tkKB@liszt>
List-Post: <mailto:debian-sparc@lists.debian.org>
List-Help: <mailto:debian-sparc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-sparc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-sparc-request@lists.debian.org?subject=unsubscribe>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Josip Rodin <joy@entuzijast.net>, linux-ide@vger.kernel.org, debian-sparc@lists.debian.org, Nataraj M Basappa <nataraj.m.basappa@gmail.com>, Hugh Pumphrey <H.C.Pumphrey@ed.ac.uk>
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 24, 2009 at 02:57:54PM +0100, Alan Cox wrote:
> >  * pata_ali.c   - ALI 15x3 PATA for new ATA layer
> >  * based in part upon
> >  * linux/drivers/ide/pci/alim15x3.c             Version 0.17    2003/01/02
> > 
> >  *  TODO/CHECK
> >  *      Review Sunblade workaround.
> > 
> > I'm sending this to the IDE list - what is the status of this driver,
> > and what can the users do to help?
> 
> Short of someone with a Sunblade and suitable documentation probably not
> a lot. The libata driver has some sunblade workarounds but I simply didn't
> have documentation on the Sun side of it sufficient to complete the job

One possibility to get relevant documentation would be to request controller
specs via Sun FOSS hardware docs website:

http://wikis.sun.com/display/FOSSdocs

Best regards, 
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
