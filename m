From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Mon, 13 Nov 2006 20:32:52 +0100
Message-ID: <1163446372.15249.190.camel@laptopd505.fenrus.org>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:14465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932862AbWKMTdW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 14:33:22 -0500
In-Reply-To: <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 19:56 +0100, Mathieu Fluhr wrote:
> On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
> > Mathieu Fluhr wrote:
> > > Hello,
> > > 
> > > I recently tried to burn some datas on CDs and DVD using a SATA burner
> > > and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> > > the device by sending SCSI commands over the 'sg' driver)
> > > 
> > 
> > Please note that the sg interface is depreciated.  It is now recommended 
> > that you send the CCBs directly to the normal device, i.e. /dev/hdc.
> 
> Of course for native IDE devices, we are using the /dev/hdXX device, but
> for SATA devices controlled by the libata, this is not possible ;)

for those there is /dev/scd0 etc...

(usually nicely symlinked to /dev/cdrom)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

