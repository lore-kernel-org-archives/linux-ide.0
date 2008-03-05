From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it
 means."
Date: Wed, 5 Mar 2008 11:56:10 +0000
Message-ID: <20080305115610.397b3ea3@the-village.bc.nu>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
	<200803050234.40594.bzolnier@gmail.com>
	<20080304173058.7679b7c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756092AbYCEPBe@vger.kernel.org>
In-Reply-To: <20080304173058.7679b7c8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


> I didn't know any of that.  The changelog might have been kinda fun, but
> given that it failed to tell us that the patch fixes data-corruption
> errors, the changelog was excrutiatingly bad.

I have no reason/evidence to believe it fixes data corruption errors of
any kind. For the specific combinations of device it should simply avoid
a long pause, complaints and a switch to lower speeds.

The ATA disk case with serverworks (which is a potential corruptor) was
always correctly handled.
