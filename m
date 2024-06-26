Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB221176ABF;
	Wed, 26 Jun 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399453; cv=none; b=dhJyIB3/YcWNVPpP832itFsGhlOI9FpZmqcIim83sgk0nCaEMH0qTardve9kvPnQRn7OxLciaAm69orwWj+J2iQTzH732m3TYXeJw5EH0E628d7VIgcNEYTNwRlcpN1dNaz0wE9CVaqXv/8wzvCVjmD3NdEgTC3gELrtLirgYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399453; c=relaxed/simple;
	bh=KQVlKkLk8LCpNcMoR7rjlrkwTL2c/OFIAQvVsYLUIYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTwicv5y1u9n2o6I+3301Rz3CK7hW2ESC7dys2Rm09IiQsF5QkIoMVbd6E3xoE6GPgIGwfL+sOGd5Fiqj067VKkxTo7cafzQYf4347VQTeBmlfdG26kaVG3cXQC5AgV7kpLqD1zaB6RbT2SILFiQenmNknuvMCmUiKX4pJRwObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpZpCg93; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpZpCg93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719399451; x=1750935451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQVlKkLk8LCpNcMoR7rjlrkwTL2c/OFIAQvVsYLUIYg=;
  b=LpZpCg93V3+N4I79+SsOOHwseon/YqiF1GU9B6iycIkoqyZNXs7BeVD0
   8TWecHaeT8RQx6EyS4X4w6QkpOYrz8mK/S49f01jdThIA5tosWzPcuO7j
   wS4mE+EK6J+tK9gchxd+GiJyWCSKxkVA8j5HjdVpSeGth9m3j9t1ekirT
   VUC7RJy1+QxTmUHcwAe3nzcw7tp7Db7GXaSdEPgCxLNTa6/dKO1egTOX5
   VcygPSziAdWgAxlzCPl3xYuUof7lhBqxfHj8k738BFY5Xnqgma5/vuZjQ
   H3oBxA47zoXANDkKWdTTb/9zdNZ938yxWGNyDevAqABz6hErLkQPTyhJi
   A==;
X-CSE-ConnectionGUID: hjQw8fUDTuuPbT7PlGADog==
X-CSE-MsgGUID: 8BwgAkihQb6lprkvKKZlGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="38974652"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="38974652"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:57:30 -0700
X-CSE-ConnectionGUID: F7YpKNaMTCaAmI28LcU2JA==
X-CSE-MsgGUID: VvrieR5DQZugXY59GNp7Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44616084"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2024 03:57:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMQL7-000FDK-23;
	Wed, 26 Jun 2024 10:57:25 +0000
Date: Wed, 26 Jun 2024 18:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Subject: Re: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer
 memsets
Message-ID: <202406261836.Q3sEjY8b-lkp@intel.com>
References: <20240624221211.2593736-4-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624221211.2593736-4-ipylypiv@google.com>

Hi Igor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Pylypiv/ata-libata-scsi-Do-not-overwrite-valid-sense-data-when-CK_COND-1/20240625-215527
base:   linus/master
patch link:    https://lore.kernel.org/r/20240624221211.2593736-4-ipylypiv%40google.com
patch subject: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer memsets
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240626/202406261836.Q3sEjY8b-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261836.Q3sEjY8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261836.Q3sEjY8b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ata/libata-scsi.c: In function 'ata_gen_passthru_sense':
>> drivers/ata/libata-scsi.c:929:24: warning: unused variable 'sb' [-Wunused-variable]
     929 |         unsigned char *sb = cmd->sense_buffer;
         |                        ^~


vim +/sb +929 drivers/ata/libata-scsi.c

^1da177e4c3f41 drivers/scsi/libata-scsi.c Linus Torvalds  2005-04-16  909  
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  910  /*
750426aa1ad1dd drivers/ata/libata-scsi.c  Tejun Heo       2006-11-14  911   *	ata_gen_passthru_sense - Generate check condition sense block.
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  912   *	@qc: Command that completed.
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  913   *
2dc8b0ba527a4a drivers/ata/libata-scsi.c  Igor Pylypiv    2024-06-24  914   *	This function is specific to the ATA pass through commands.
2dc8b0ba527a4a drivers/ata/libata-scsi.c  Igor Pylypiv    2024-06-24  915   *	Regardless of whether the command errored or not, return a sense
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  916   *	block. If there was no error, we get the request from an ATA
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  917   *	passthrough command, so we use the following sense data:
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  918   *	sk = RECOVERED ERROR
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  919   *	asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  920   *      
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  921   *
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  922   *	LOCKING:
750426aa1ad1dd drivers/ata/libata-scsi.c  Tejun Heo       2006-11-14  923   *	None.
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  924   */
750426aa1ad1dd drivers/ata/libata-scsi.c  Tejun Heo       2006-11-14  925  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  926  {
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  927  	struct scsi_cmnd *cmd = qc->scsicmd;
e61e067227bc76 drivers/scsi/libata-scsi.c Tejun Heo       2006-05-15  928  	struct ata_taskfile *tf = &qc->result_tf;
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12 @929  	unsigned char *sb = cmd->sense_buffer;
b525e7731b90eb drivers/ata/libata-scsi.c  Hannes Reinecke 2016-04-04  930  	u8 sense_key, asc, ascq;
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  931  
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  932  	/*
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  933  	 * Use ata_to_sense_error() to map status register bits
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  934  	 * onto sense key, asc & ascq.
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  935  	 */
058e55e120ca59 drivers/scsi/libata-scsi.c Tejun Heo       2006-04-02  936  	if (qc->err_mask ||
efcef265fd83d9 drivers/ata/libata-scsi.c  Sergey Shtylyov 2022-02-15  937  	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
efcef265fd83d9 drivers/ata/libata-scsi.c  Sergey Shtylyov 2022-02-15  938  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
ff8072d589dcff drivers/ata/libata-scsi.c  Hannes Reinecke 2023-07-31  939  				   &sense_key, &asc, &ascq);
06dbde5f3a4424 drivers/ata/libata-scsi.c  Hannes Reinecke 2016-04-04  940  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
84a9a8cd9d0aa9 drivers/ata/libata-scsi.c  Gwendal Grignou 2013-01-18  941  	} else {
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  942  		/*
11093cb1ef5614 drivers/ata/libata-scsi.c  Hannes Reinecke 2016-04-04  943  		 * ATA PASS-THROUGH INFORMATION AVAILABLE
11093cb1ef5614 drivers/ata/libata-scsi.c  Hannes Reinecke 2016-04-04  944  		 * Always in descriptor format sense.
b095518ef51c37 drivers/scsi/libata-scsi.c Jeff Garzik     2005-05-12  945  		 */
f2b1e9c6f867ec drivers/ata/libata-scsi.c  Hannes Reinecke 2021-04-27  946  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
11093cb1ef5614 drivers/ata/libata-scsi.c  Hannes Reinecke 2016-04-04  947  	}
^1da177e4c3f41 drivers/scsi/libata-scsi.c Linus Torvalds  2005-04-16  948  }
^1da177e4c3f41 drivers/scsi/libata-scsi.c Linus Torvalds  2005-04-16  949  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
