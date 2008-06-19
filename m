From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata support for rotation speed
Date: Thu, 19 Jun 2008 15:01:33 -0400
Message-ID: <485AAD0D.9000205@garzik.org>
References: <20080619160216.GH4392@parisc-linux.org> <20080619175904.GK4392@parisc-linux.org> <1213899895.3501.45.camel@localhost.localdomain> <20080619183113.GM4392@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080619183113.GM4392@parisc-linux.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Jun 19, 2008 at 01:24:55PM -0500, James Bottomley wrote:
>> This looks like it can be called for ATA_DEV_ATAPI as well, in which
>> case it's an illegal page to ask for.
> 
> I was under the impression that this entire file is only used for
> non-atapi devices.

Correct.  That code path is not travelled by ATAPI.

	Jeff



