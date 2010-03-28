From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: Turn off DMA engines when there's no device attached
Date: Sun, 28 Mar 2010 00:39:04 -0400
Message-ID: <4BAEDD68.60008@pobox.com>
References: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44882 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0C1EjJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 00:39:09 -0400
Received: by gxk9 with SMTP id 9so801464gxk.8
        for <linux-ide@vger.kernel.org>; Sat, 27 Mar 2010 21:39:08 -0700 (PDT)
In-Reply-To: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On 03/10/2010 03:32 PM, Matthew Garrett wrote:
> According to section 10.3.1 of the AHCI spec, PxCMD.ST must not be set
> unless there's a device attached. Following this saves us a measurable
> quantity of power and does not impair hotplug support. Based on a patch
> by Kristen Carlson Accardi.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>
> Cc: Kristen Carlson Accardi<kristen.c.accardi@intel.com>
> ---
>   drivers/ata/ahci.c |   19 +++++++++++++++++++
>   1 files changed, 19 insertions(+), 0 deletions(-)

applied manually to libata-dev.git#upstream, due to large code movements 
in creation of new libahci kernel module


