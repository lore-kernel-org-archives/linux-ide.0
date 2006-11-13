From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Mon, 13 Nov 2006 13:49:59 -0500
Message-ID: <4558BE57.4020700@cfl.rr.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iriserv.iradimed.com ([69.44.168.233]:53280 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932766AbWKMSuK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 13:50:10 -0500
In-Reply-To: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mathieu Fluhr wrote:
> Hello,
> 
> I recently tried to burn some datas on CDs and DVD using a SATA burner
> and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> the device by sending SCSI commands over the 'sg' driver)
> 

Please note that the sg interface is depreciated.  It is now recommended 
that you send the CCBs directly to the normal device, i.e. /dev/hdc.

> The burn process works like a charm, no problems at all. But it seems
> that there are some slight problems with the READ scsi cmd:
> Inside our software, we have a verification routine that will make a
> sector-by-sector verification to check that everything that has been
> written is OK.
> 
> The problem is that, on SATA devices controlled by libata, on some big
> files (like for example a 600 MB file) the READ command seems to fail
> and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
>  -> This problem does not come out everytime, and each time on    
>     different sectors.
> 

I'm not sure what you mean by "on some big files" as the sg interface 
has no notion of files; you're just reading the disk sector by sector, 
as you said earlier.  Also by fail do you mean that the request returns 
an error status?  If so then the read buffer will not be valid.


