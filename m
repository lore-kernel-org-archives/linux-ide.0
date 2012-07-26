From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 0/2] ata: MODE SELECT implementation
Date: Thu, 26 Jul 2012 09:47:16 -0400
Message-ID: <50114A64.8090500@pobox.com>
References: <1341481235-12708-1-git-send-email-pbonzini@redhat.com> <5010F104.5080606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42817 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2GZNrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2012 09:47:20 -0400
In-Reply-To: <5010F104.5080606@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 07/26/2012 03:25 AM, Paolo Bonzini wrote:
> Il 05/07/2012 11:40, Paolo Bonzini ha scritto:
>> This is a revised version of the MODE SELECT implementation from yesterday,
>> augmented with support for changeable parameter requests in MODE SENSE.
>>
>> Paolo Bonzini (2):
>>    ata: support MODE SENSE request for changeable parameters
>>    ata: implement MODE SELECT command
>>
>>   drivers/ata/libata-scsi.c |  242 +++++++++++++++++++++++++++++++++++++++++----
>>   1 files changed, 221 insertions(+), 21 deletions(-)
>>
>
> Ping, no love for these? :)

These will go in #upstream for the next kernel...

	Jeff





