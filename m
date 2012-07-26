From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] ata: MODE SELECT implementation
Date: Thu, 26 Jul 2012 15:55:56 +0200
Message-ID: <50114C6C.4070102@redhat.com>
References: <1341481235-12708-1-git-send-email-pbonzini@redhat.com> <5010F104.5080606@redhat.com> <50114A64.8090500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab2GZN4E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2012 09:56:04 -0400
In-Reply-To: <50114A64.8090500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Il 26/07/2012 15:47, Jeff Garzik ha scritto:
>>>
>>>
>>> Paolo Bonzini (2):
>>>    ata: support MODE SENSE request for changeable parameters
>>>    ata: implement MODE SELECT command
>>>
>>>   drivers/ata/libata-scsi.c |  242
>>> +++++++++++++++++++++++++++++++++++++++++----
>>>   1 files changed, 221 insertions(+), 21 deletions(-)
>>>
>>
>> Ping, no love for these? :)
> 
> These will go in #upstream for the next kernel...

Ok, thanks (BTW I pinged v2 but there is a v3 too).

Paolo

