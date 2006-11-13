From: Mathieu Fluhr <mfluhr@nero.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Mon, 13 Nov 2006 19:56:00 +0100
Message-ID: <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s1.mailresponder.info ([193.24.237.10]:12819 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S1755327AbWKMS42 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 13:56:28 -0500
Received: from moonfish.nero.com (193.47.77.31)
          by s1.mailresponder.info with MERCUR Mailserver (v4.02.30 ODAtMjQzOS03MTc5)
          for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 19:56:07 +0100
In-Reply-To: <4558BE57.4020700@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
> Mathieu Fluhr wrote:
> > Hello,
> > 
> > I recently tried to burn some datas on CDs and DVD using a SATA burner
> > and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> > the device by sending SCSI commands over the 'sg' driver)
> > 
> 
> Please note that the sg interface is depreciated.  It is now recommended 
> that you send the CCBs directly to the normal device, i.e. /dev/hdc.

Of course for native IDE devices, we are using the /dev/hdXX device, but
for SATA devices controlled by the libata, this is not possible ;)

> 
> > The burn process works like a charm, no problems at all. But it seems
> > that there are some slight problems with the READ scsi cmd:
> > Inside our software, we have a verification routine that will make a
> > sector-by-sector verification to check that everything that has been
> > written is OK.
> > 
> > The problem is that, on SATA devices controlled by libata, on some big
> > files (like for example a 600 MB file) the READ command seems to fail
> > and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
> >  -> This problem does not come out everytime, and each time on    
> >     different sectors.
> > 
> 
> I'm not sure what you mean by "on some big files" as the sg interface 
> has no notion of files; you're just reading the disk sector by sector, 
> as you said earlier.  Also by fail do you mean that the request returns 
> an error status?  If so then the read buffer will not be valid.

I said 'some big files', as the problem is not reproducable everytime.
It occurs most of the time with large files.
The request does not return an error code (no sense key I mean), and it
is working as if everything would have work fine.

> 
> 

