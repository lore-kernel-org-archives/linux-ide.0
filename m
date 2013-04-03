From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: Use integer return value for atapi_command_packet_set
Date: Wed, 03 Apr 2013 19:35:29 -0400
Message-ID: <515CBCC1.1020805@pobox.com>
References: <1363573844-12729-1-git-send-email-shan.hai@windriver.com> <1363573844-12729-2-git-send-email-shan.hai@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:47501 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762442Ab3DCXfc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:35:32 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so1195456qej.9
        for <linux-ide@vger.kernel.org>; Wed, 03 Apr 2013 16:35:31 -0700 (PDT)
In-Reply-To: <1363573844-12729-2-git-send-email-shan.hai@windriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shan Hai <shan.hai@windriver.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On 03/17/2013 10:30 PM, Shan Hai wrote:
> The function returns type of ATAPI drives so it should return integer value.
> The commit 4dce8ba94c7 (libata: Use 'bool' return value for ata_id_XXX) since
> v2.6.39 changed the type of return value from int to bool, the change would
> cause all of the ATAPI class drives to be treated as TYPE_TAPE and the
> max_sectors of the drives to be set to 65535 because of the commit
> f8d8e5799b7(libata: increase 128 KB / cmd limit for ATAPI tape drives), for the
> function would return true for all ATAPI class drives and the TYPE_TAPE is
> defined as 0x01.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shan Hai <shan.hai@windriver.com>
> ---
>   include/linux/ata.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied 1-2



