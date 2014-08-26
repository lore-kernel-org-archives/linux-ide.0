From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 8/8] ARM: tegra: Add options for Tegra AHCI support
 to tegra_defconfig
Date: Tue, 26 Aug 2014 11:46:41 -0600
Message-ID: <53FCC801.5000703@wwwdotorg.org>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com> <1405500863-19696-9-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48791 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaHZRqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2014 13:46:45 -0400
In-Reply-To: <1405500863-19696-9-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@gmail.com, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org

On 07/16/2014 02:54 AM, Mikko Perttunen wrote:
> This adds ATA, SATA_AHCI and AHCI_TEGRA support to tegra_defconfig
> so that the SATA support will be automatically enabled.

I've applied this to Tegra's for-3.18/dt branch.
