From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RFC 1/1] AHCI: Optimize interrupt processing
Date: Wed, 03 Apr 2013 19:56:41 -0400
Message-ID: <515CC1B9.2090500@pobox.com>
References: <cover.1362568800.git.agordeev@redhat.com> <7aaa7f37e742bf57e3043be865774b8a1f033d86.1362568800.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:41863 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191Ab3DCX4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:56:43 -0400
In-Reply-To: <7aaa7f37e742bf57e3043be865774b8a1f033d86.1362568800.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 03/06/2013 06:26 AM, Alexander Gordeev wrote:
> Split interrupt service routine into hardware context handler and
> threaded context handler. That allows to protect ports with individual
> locks rather than with a single host-wide lock, which results in better
> parallelism.
>
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>   drivers/ata/acard-ahci.c    |    8 ++---
>   drivers/ata/ahci.c          |   54 ++++++++++++++++++-------------
>   drivers/ata/ahci.h          |   10 +++--
>   drivers/ata/ahci_platform.c |    3 +-
>   drivers/ata/libahci.c       |   74 +++++++++++++++++++++++++------------------
>   5 files changed, 85 insertions(+), 64 deletions(-)

applied



