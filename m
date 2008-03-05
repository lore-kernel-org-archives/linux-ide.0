From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it means."
Date: Wed, 5 Mar 2008 14:21:13 +0100
Message-ID: <200803051421.14167.bzolnier@gmail.com>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org> <20080304173058.7679b7c8.akpm@linux-foundation.org> <20080305115610.397b3ea3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934525AbYCENIl@vger.kernel.org>
In-Reply-To: <20080305115610.397b3ea3@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 05 March 2008, Alan Cox wrote:
> 
> > I didn't know any of that.  The changelog might have been kinda fun, but
> > given that it failed to tell us that the patch fixes data-corruption
> > errors, the changelog was excrutiatingly bad.
> 
> I have no reason/evidence to believe it fixes data corruption errors of
> any kind. For the specific combinations of device it should simply avoid
> a long pause, complaints and a switch to lower speeds.

http://www.mail-archive.com/linux-ide@vger.kernel.org/msg16599.html

There is strange coincidence with being on the blacklist and FIFO corruption.

https://bugzilla.redhat.com/show_bug.cgi?id=433557

Bugzilla Bug 433557: Data corrupion with Fedora8 on HPT370 disk controller (Abit BX133 mobo)

IBM-DTLA-307030 is on the blacklist....

[ there can be more libata problems involved, anyway FC6 w/IDE works fine ]

> The ATA disk case with serverworks (which is a potential corruptor) was
> always correctly handled.

for OSB4 yes but...

/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
 * can overrun their FIFOs when used with the CSB5 */

static const char *csb_bad_ata100[] = {

Thanks,
Bart
