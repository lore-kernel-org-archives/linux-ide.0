From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] block,libata: implement ->unlock_native_capacity()
Date: Wed, 19 May 2010 09:05:40 +0200
Message-ID: <4BF38DC4.3090900@gmail.com>
References: <1273946974-29131-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52515 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0ESHFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 03:05:45 -0400
In-Reply-To: <1273946974-29131-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-scsi@vger.kernel.org, James.Bottomley@suse.de, linux-kernel@vger.kernel.org, ben@decadent.org.uk, davem@daveml

On 05/15/2010 08:09 PM, Tejun Heo wrote:
> Hello, all.
> 
> This is the evolved version of the implement-set_capacity patchset[L]
> and contains the following patches.
> 
>  0001-buffer-make-invalidate_bdev-drain-all-percpu-LRU-add.patch
>  0002-block-restart-partition-scan-after-resizing-a-device.patch
>  0003-block-ide-simplify-bdops-set_capacity-to-unlock_nati.patch
>  0004-block-use-struct-parsed_partitions-state-universally.patch
>  0005-block-improve-automatic-native-capacity-unlocking.patch
>  0006-SCSI-implement-sd_unlock_native_capacity.patch
>  0007-libata-use-the-enlarged-capacity-after-late-HPA-unlo.patch
>  0008-libata-implement-on-demand-HPA-unlocking.patch

Other than block part, everything is acked, so how do we route this?
0001-0005 through block tree and 0006-0008 through libata tree seem
the easiest unless someone objects.  Jens, can you please review
0001-0005 and take them into block tree if it seems okay?

Thanks.

-- 
tejun
