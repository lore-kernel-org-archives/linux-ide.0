From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2 resend] libata-sff: avoid byte swapping in ata_sff_data_xfer()
Date: Wed, 08 Apr 2009 02:33:41 -0400
Message-ID: <49DC4545.5020702@pobox.com>
References: <200902152230.38271.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54838 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760855AbZDHGdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 02:33:46 -0400
In-Reply-To: <200902152230.38271.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Handling of the trailing byte in ata_sff_data_xfer() is suboptimal bacause:
> 
> - it always initializes the padding buffer to 0 which is not really needed in
>   both the read and write cases;
> 
> - it has to use memcpy() to transfer a single byte from/to the padding buffer;
> 
> - it uses io{read|write}16() accessors which swap bytes on the big endian CPUs
>   and so have to additionally convert the data from/to the little endian format
>   instead of using io{read|write}16_rep() accessors which are not supposed to
>   change the byte ordering.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied


