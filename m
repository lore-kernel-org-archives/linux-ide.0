From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 3/8] ahci: Add a driver_data field to struct
 ahci_platform_data
Date: Thu, 23 Jan 2014 06:36:44 -0500
Message-ID: <20140123113644.GA28621@htj.dyndns.org>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35769 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaAWLgt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jan 2014 06:36:49 -0500
Content-Disposition: inline
In-Reply-To: <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, Jan 23, 2014 at 04:02:43PM +0530, Mohit Kumar wrote:
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 73a2500..76d35e8 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -28,6 +28,7 @@ struct ahci_platform_data {
>  	const struct ata_port_info *ata_port_info;
>  	unsigned int force_port_map;
>  	unsigned int mask_port_map;
> +	void *driver_data;

Please use private_data instead for consistency with other ata data
structures.

Thanks.

-- 
tejun
