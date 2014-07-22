From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: st: Make of_device_id array const
Date: Tue, 22 Jul 2014 11:44:00 -0400
Message-ID: <20140722154400.GK13851@htj.dyndns.org>
References: <1406038543-26545-1-git-send-email-kiran.padwal21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:39708 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbaGVPoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 11:44:04 -0400
Content-Disposition: inline
In-Reply-To: <1406038543-26545-1-git-send-email-kiran.padwal21@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kiran Padwal <kiran.padwal21@gmail.com>
Cc: lee.jones@linaro.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 22, 2014 at 07:45:43PM +0530, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const.
> 
> Signed-off-by: Kiran Padwal <kiran.padwal21@gmail.com>

Applied to libata/for-3.17.

Thanks.

-- 
tejun
