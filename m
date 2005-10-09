From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] libata: scsi error handling, encore
Date: Sun, 09 Oct 2005 13:43:20 -0400
Message-ID: <434956B8.1050105@pobox.com>
References: <43490BC8.9060504@torque.net> <434919E4.1080601@pobox.com> <434953C4.4000201@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <434953C4.4000201@adaptec.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: dougg@torque.net, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com, russb@emc.com
List-Id: linux-ide@vger.kernel.org

Luben Tuikov wrote:
> * libata-scsi would need a _lot_ of changes to become SATL.  Would
> it be more efficient to start from a clean slate (drivers/scsi/satl/satl.c)
> or change libata-scsi beyond recognition?  What is the political stance
> on this?

We don't need multiple ATA<->SCSI simulators in the kernel.

	Jeff


