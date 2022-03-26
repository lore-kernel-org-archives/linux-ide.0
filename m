Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37276C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 26 Mar 2022 18:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiCZSPI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Mar 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiCZSPH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Mar 2022 14:15:07 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE213D30
        for <linux-ide@vger.kernel.org>; Sat, 26 Mar 2022 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648318411; x=1679854411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtI7Aa28UKSIFk8cMhmSpV6HQgtqYhNyt+d804h6PN4=;
  b=jiJ+fnkAIP+C/VpimuTNP5iKQJLDnnAcPn2MWcF+EO/i9aCaoxPV/5nl
   bC50b5m8yVOovOIGtzEM9V12TYmySqPtFDjXzkpQlecL0xBtbfs5QTawo
   M1A9rNo6aarhhpL1TkN9cb/VTdG0/owTbQpNKU4oMDm/m1KkgHe+58top
   juZKJJvuZvw86M/ct+GUj84z/qAYUByn6jAwsMvqID7iDdSLBRgiDNhy1
   meDLt6tz156Vwn7uEiFOnWFr+w46mthbUUCTWIdc7mpyTUuhI3RCuSxmI
   k7sZNL/UdgeneDNVjHA9Wd2GPjR+XTaRgX52/MNxf+0IXbZxu+J4GF/Za
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="319500780"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="319500780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 11:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="650565164"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2022 11:13:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYAum-0000Gg-NF; Sat, 26 Mar 2022 18:13:28 +0000
Date:   Sun, 27 Mar 2022 02:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] libata: rework sysfs naming
Message-ID: <202203270220.q1Q39xe4-lkp@intel.com>
References: <20220325125624.99929-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325125624.99929-2-hare@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Hannes,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hannes-Reinecke/libata-sysfs-naming/20220325-205722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 34af78c4e616c359ed428d79fe4758a35d2c5473
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220327/202203270220.q1Q39xe4-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/ba4273174499b7351d34ffc22021d0c382cb1d63
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hannes-Reinecke/libata-sysfs-naming/20220325-205722
        git checkout ba4273174499b7351d34ffc22021d0c382cb1d63
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/ata/libata-transport.c:88:17: sparse: sparse: symbol 'ata_bus_type' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
