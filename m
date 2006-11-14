From: Mathieu Fluhr <mfluhr@nero.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Tue, 14 Nov 2006 16:45:25 +0100
Message-ID: <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
	 <1163446372.15249.190.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s1.mailresponder.info ([193.24.237.10]:58120 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S966127AbWKNPqs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 10:46:48 -0500
Received: from moonfish.nero.com (193.47.77.31)
          by s1.mailresponder.info with MERCUR Mailserver (v4.02.30 ODAtMjQzOS03MTc5)
          for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 16:45:33 +0100
In-Reply-To: <1163446372.15249.190.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Phillip Susi <psusi@cfl.rr.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 20:32 +0100, Arjan van de Ven wrote:
> On Mon, 2006-11-13 at 19:56 +0100, Mathieu Fluhr wrote:
> > On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
> > > Mathieu Fluhr wrote:
> > > > Hello,
> > > > 
> > > > I recently tried to burn some datas on CDs and DVD using a SATA burner
> > > > and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> > > > the device by sending SCSI commands over the 'sg' driver)
> > > > 
> > > 
> > > Please note that the sg interface is depreciated.  It is now recommended 
> > > that you send the CCBs directly to the normal device, i.e. /dev/hdc.
> > 
> > Of course for native IDE devices, we are using the /dev/hdXX device, but
> > for SATA devices controlled by the libata, this is not possible ;)
> 
> for those there is /dev/scd0 etc...
> (usually nicely symlinked to /dev/cdrom)

Hummm as we are _writing_ to devices, I think that using /dev/sgXX with
SG_IO is better no?

... and the problem is not in accessing the device itself (this is
working like a charm) but understanding why a SCSI READ(10) cmd
sometimes fails as a ATA-padded READ(10) cmd - as discribed in the Annex
A of the MMC-5 spec - ALWAYS works.
-> I would suspect somehow a synchronisation problem somehow in the
translation of SCSI to ATA command...

Another point: When I say that a READ(10) fails, it does NOT mean that
the command execution itself fails. Everything works as if the command
exectution succeeds, but the resulting buffer contains garbage (i.e. not
only 1 or 2 bytes differs)


> 
> 

