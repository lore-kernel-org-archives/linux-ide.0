From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: add PCI ID for Marvell 88SE9170 SATA controller
Date: Tue, 31 Dec 2013 07:24:41 -0500
Message-ID: <20131231122441.GD3985@htj.dyndns.org>
References: <1387801475-32451-1-git-send-email-simon.guinot@sequanux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:38950 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab3LaMYo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2013 07:24:44 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so11708713qcz.16
        for <linux-ide@vger.kernel.org>; Tue, 31 Dec 2013 04:24:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387801475-32451-1-git-send-email-simon.guinot@sequanux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: linux-ide@vger.kernel.org, Simon Guinot <sguinot@lacie.com>

On Mon, Dec 23, 2013 at 01:24:35PM +0100, Simon Guinot wrote:
> From: Simon Guinot <sguinot@lacie.com>
> 
> This patch adds support for the PCI ID provided by the Marvell 88SE9170
> SATA controller.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>

Applied to libata/for-3.13-fixes w/ stable cc'd.

Thanks.

-- 
tejun
