From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibATA ATAPI-Found lockup spot.
Date: Tue, 18 Jan 2005 14:43:20 -0500
Message-ID: <41ED66D8.2040808@pobox.com>
References: <20050118191122.4DC7ACA0AF@ws7-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13224 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261452AbVARTnn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Jan 2005 14:43:43 -0500
In-Reply-To: <20050118191122.4DC7ACA0AF@ws7-4.us4.outblaze.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kien Pham <kienca@lycos.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Kien Pham wrote:
> Hi Jeff,
> 
> It blocks forever on line 2450 of libata-core.c. This is on vanilla 
> 2.6.10 kernel source. Relevent snippet follows so you don't have to dig. 
> Basically, the middle SCSI layer successfully sends 3 INQUIRY commands. 
> Then it sends a REPORT LUNs command that fails with a status 0x50. The 
> error register reads 0x60 at this point. Then the ATAPI layer sends a 
> REQUEST SENSE which never completes because an interrupt never occurs 
> and we're stuck at line 2450 waiting for completion. O.K. I know the how 
> it happens, any ideas on the why? Or am I on my own? :)


I think Bart mentioned something about problems with REPORT LUNS... I 
bet things would work if we didn't send that command...

	Jeff


