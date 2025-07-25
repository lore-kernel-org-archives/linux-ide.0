Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0C2D190C
	for <linux-ide@vger.kernel.org>; Fri, 25 Jul 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435772; cv=fail; b=uLJaK+QGTsZG5CZYU5HwcKfTh7iJ2YY2QvTxKdpOtxutxhrFiYuUfW0PzKnbyu/i7mu447QqSOHIdw5I1jLAWpj+4FQcmGSLDSrQydHPOqFcjSaddjRxAnsW+5tb0SiHOSFmZMTF0X9zE/2msp81KfkoyXvmwbsZFGzrVqD+crY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435772; c=relaxed/simple;
	bh=trI/PcULIt3xFNmzopaSa5TVVfzwcsIaeHp1ja0JoAc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UbmMpUh7oLNNghIpSv+G1oqHMnvNApJ5xIJ6lZcqqUshu2MZJwSayEv/caJuIZkoyO7rGrBsKtoUs0j4lf1mh+0Qco5J/7Cclf9vr8J/nnCUdoYvBGbacuUZnwNQX2PX+4g4kopy7sgodIC2z7y1L2wEhP+k5jXeXtBoB6WD9XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk4sN7Jo; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk4sN7Jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753435771; x=1784971771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=trI/PcULIt3xFNmzopaSa5TVVfzwcsIaeHp1ja0JoAc=;
  b=Fk4sN7JoQUSuAt5ymYKGvMS29O0mg9DGbLCBoZUshU4xxT+p4d/hP/eU
   I0eGeLCGsyszmXAx15QfxzCKJxvb5NXOniHXHGNHurzo8tGeFtiMhK+Be
   pVBWV8JMvJR3pGsLwJzUYvQ7ehyQcjwGnZspVH9+eW21sgjcnOt17Rc9j
   5gJ6TQQIPFPbPEgNUlVRLWgD1+Hw0rPbfkDfbQ1TzYWW8nTwRk+c6LxVz
   fvCpF5IaZfvEfy9qkTsz9Aj0xSIT1+6Saws7COai1pVJ59NsY+7NiKe1x
   4WflX4a1azmzkEUFxqx1tZDo8pe0h9To93mSQTDacx95X4CaDYFgzMBlS
   g==;
X-CSE-ConnectionGUID: jzcPW2oRTk+ZzMPZkm3JcQ==
X-CSE-MsgGUID: vKTQsIGVQlOk+aCqF3j52w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81207834"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81207834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:29:31 -0700
X-CSE-ConnectionGUID: Ni3Wg9XoScuPzkKXlqhiKg==
X-CSE-MsgGUID: wZJY0aNlSTO0w4BjTkV3NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="165326288"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:29:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:29:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:29:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/J6hKMiojb3apkfE8VklSUk/VC4821pPWvj9813zReTQ54vZoNfBnk81wx9WK5QrYV4OzF2v4DpBiKSa3omiCEehkg0hGxHT0SE7uKs5d6HtOgvreaK3il9u2pFoOB1XZFYAOKfNBPxSUZY/e4igeVwWmJ6AcPkGJ2a8UX762wj25e9HMT2vyEG1Cn99jfocHaIIzbfPI5YQ743MOYHYdlx3w+F0UX2WVdFXKyHoEodo4RJnmiY8bL4qOyYdMRfRRL5ydo2w1E4Rapx50zwkcWZf3rpiCrhchfub4Xowp3JYcnzC49dPymsIb7q6pbZG657INghdje5qxy3MW5CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDO4AwXjDZz9iR08s+EM3DtWHUyOiC+8CbMyYRGxZ30=;
 b=hCvn+I8VJSUDPgGaRHcjBIdRZuj/6Pf9AehPJp/51xYWPCH0AOBIhqbMgd6d18vb4VLVgm5cR5Sa4hlZ9g82Gsflfw+drqVlTq3nJtKaCl3O29Xq+tmXVHLDXbzAF2QX1jxS2fjNNyqtuMKcvKqAedq25Lwgd1wpsNpt123+V3SNgL0/GiCan4n76LagH+hXpTvGj7qdpEHFpnX1ovELvnyoRUO6bP48h0IQh7RpRlps3fQ12YjmgHT4EoCVcxfhhRDq0NYk5t8WTSRt7OB4Ariy40xVkJywYhJtKL9F7MjSVudv6LuSTLyjjluHx5nacOf18onbxJrYbjp6/IOudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 09:29:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 09:29:26 +0000
Date: Fri, 25 Jul 2025 17:29:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
	<linux-ide@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [ata]  4edf1505b7: assertion_failure
Message-ID: <202507251014.a5becc3b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF67C992ECC:EE_
X-MS-Office365-Filtering-Correlation-Id: 635c6ba6-90a0-46e9-a9f9-08ddcb5dbfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOHyi1XHLw68UrqWc4JXkD1YFQa9ykSI4B66XVw+z5waTNAhWMbukcM/AWCl?=
 =?us-ascii?Q?w4ka6ad8gtAChSjmVIM3nkqkbLHNhr6zhKQq7fNlLC5VR80xhCycB5T58LE1?=
 =?us-ascii?Q?YzBLfHR98Yjbkr7KP4DSqsWHgpQ4NSXNAauJMzDSBeIMslpwfjPsoHJPA2yo?=
 =?us-ascii?Q?SITceH5HV7WT1/aKxKAVw59C55ibZ8lD/4N9URWti7dfB2YT9EZrtq8flp1K?=
 =?us-ascii?Q?NXMAP9+NJQadUCxGxrDb/pe4UKhU9xZgqVIN+PzDGkF4//HE86bgQ6wo6M+g?=
 =?us-ascii?Q?sg9HzSFSUhXHRl9CBXoVgmN8b5bXeHVA/0lnp5ou0EsltuTVXRroFinaVO6g?=
 =?us-ascii?Q?XLczMvykbZa6MQY8ajvJ3DARcrWxfPfsQOC/PVWKfznf7PqJpuUOje0xREv5?=
 =?us-ascii?Q?d/hffILyhQf2nH7LGr1j1sngbteCl8b8aTjCjsg5KZxHLw1RdUvwqGjQs/0G?=
 =?us-ascii?Q?4tn6wGzec122mQCx7XSbfj6EA62xJh8eLjS6BSm+p7ecE5e2VzI+jUZLttYi?=
 =?us-ascii?Q?6BeiGPQGxx9fP/Ty/PFIz7muJ0JxtFFGq0OmBjZoMrNHIkbcpPCzR6iH4nSh?=
 =?us-ascii?Q?WMHA05VzE3bupu4evJrDlMq43wZTYrWSeZB5qNgQpytbqnNZFmXrCm4scF2n?=
 =?us-ascii?Q?XcNwVWnWLGlA4b/mYOiWP6HKNmASrB83et8VwrXisGbyT2z5bmHrcjc8PA1W?=
 =?us-ascii?Q?X0tyezRgweIXYehKV0knx3nY9ts9ngCtkrptZv2f2eNe/SWCH7QFCigggFyf?=
 =?us-ascii?Q?hmTwsd9UefoDAprL1gtUtQ/szz8BJD6SqFLfmjezfQn81MMry9kl79aKSK9D?=
 =?us-ascii?Q?ilM3F327VxGcSalqhDkTSuV6IgSRzXA0Le51KnJy6DSOHT46iSTQ2DpIz9KN?=
 =?us-ascii?Q?yA2ovvBx7EQKYtJh1nN7wE5BIYAPVNNBAK4wDZqqr2dSEly6xdBuIVs4Lcgz?=
 =?us-ascii?Q?yGY/2vk5YyCrWWnvcIpl8VwAt8NCWp0p3MXFWHjmIHX6HAeaLxRTNMefqtIq?=
 =?us-ascii?Q?kJwzlIFzsKec/GUTNFYuJ7SHlkgm8OC9qa1gpPMAtkHCCOASt+TiUByssb2b?=
 =?us-ascii?Q?6dsrldiEknaf3042E+y68KhNf8dXNKfS18fDqzk7Df9WWNYqRo5cacFH97/4?=
 =?us-ascii?Q?vynRbJsQ/+r1ZM/xDFB33AM0rOt1PWGVLq08NVYlYZbTN+tYKc9NRzrxw1d2?=
 =?us-ascii?Q?Wg/nmOsCxSM5jDgja1ycVUnfnbEpky/Uk9+DnxtxAAbEdZItUVMvFBI7qzBZ?=
 =?us-ascii?Q?WTdCSiwmuUJanFLG0grDk945PaXmksfcp01HKNNulntxoT1XqteSKIQNwqUd?=
 =?us-ascii?Q?3IzO+o3gOdHizYXHmJe2xHM9+q9WqJ8kEQXvdPvG6Bz+xaOjD/Ia7mz7yN01?=
 =?us-ascii?Q?oad5zEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrTuepeP1IgbXCHVHt+TkCYrVGw6jiSidaNGuzjHQiqMZvsGatsAEBqjHmLm?=
 =?us-ascii?Q?RPK4bLPQWACBEZIMfLP7S8NgMAL9ZuyiQufBSQD0Xl1Zw30eREWu4NKL9f+P?=
 =?us-ascii?Q?xJUECKPO6VYvPhe6wUSTnt/3RUm6PoXqywyDk7cI3sw0xqPPWggpyodV44zg?=
 =?us-ascii?Q?vo05N9cQkMwqQ/4nc69DAH6ySWZxjczKhA3xRL5RZIZD2C0QsvEOaMpu6124?=
 =?us-ascii?Q?7+5fkBFQNHojg9OT+Adb1VxqvTZ5dwh9NjJLkuIGZ62oyQwxaya6DoRmTet6?=
 =?us-ascii?Q?zQBSvJs+uF1JbnyFEKFvMGIN9BkLjTcNGSxlv0QSPeoVI5tBAdcTF9vymL/t?=
 =?us-ascii?Q?YK7Y5yTJaR2B9GwlGWSxWcdjzV8vg6hpQCIf+s4R8INrqOqpMeNFOZLBAcSa?=
 =?us-ascii?Q?MfvZ4zpDc0xJM45mb8N+wp7RJLJ0LUzAQWkjQma/ADytnMTfXl2sEUe1QYoU?=
 =?us-ascii?Q?Xalxy4KA2u5djEkHGzkJ7DnfAdDk3tXVf3MQ2IO/h/5WLSYNGSA/WkrxLwio?=
 =?us-ascii?Q?u1HxXNK/8THluUQgxbcC/ZhYCT9aSLo7i5af+w74aHwF3Z2KtJDsqmYKMWCc?=
 =?us-ascii?Q?RTd+IlrpviuR9+pcP21NCaxoQBhFbfbEcf2sx/RstsPjy3b+Fhub9ZlXB4y6?=
 =?us-ascii?Q?ao8lxuEgS691hKN1Qh4gXBaO+yz15a4uRjYKHHq4u6rcswPL9UTmL8cyoL7C?=
 =?us-ascii?Q?G/fnYDXxvlkFxEfYs2hGLs2i3xaeLO8TnsRhqQNvIst8MJgpQST7lpkpucQp?=
 =?us-ascii?Q?7n24BWAn0FwholAYArmxx/eBwdh0bnT9a0aPAM6dXDqrUqf+Um5KKpf5CJ57?=
 =?us-ascii?Q?nWhV2BnQIxh3lTf7ry/p5cl2is3adOVV8ioi0sbkICnxrpG3Y1exvrle+Vdg?=
 =?us-ascii?Q?xpNr6XMBZ8OoZYLu6HEPLJCl6sxF9HhhifOF5S4gCkK901LzKdnNj87pfTjG?=
 =?us-ascii?Q?Jd0TMA7/XsHaB+j/uoDP4BbNcAzIWX6uex6y8uJCS2YXMhyF0/mUZ/VWbKW2?=
 =?us-ascii?Q?D42AUnsqVP6uZ9qoAIToMWnAA8lUjMNaQdPPyTAPKB6/wlC41JMeDC5Jxm0u?=
 =?us-ascii?Q?rASNJJag+RbXVeJuP3fw4pUgreuRegwbJUARKkmEvEbS2OGKc2z0vF1tovex?=
 =?us-ascii?Q?Yf9OzWafbjG8T2pjrdKEapIWZzU1D8jAK/MuCLQJqHUDsZfR6kq4BadoGFLP?=
 =?us-ascii?Q?GQJ6tKN9itQSY1vG9LxtyqgnhUUWdMzH02RnBCo895DD5D/GpOlJKhEZhC17?=
 =?us-ascii?Q?Pw6jXR9tRygNtZ+I5wsNejt9dPt2oOFSjLvaqMPXXQVy7SVkUrZ94DiRiQrt?=
 =?us-ascii?Q?O5bcRUaSm41RLuukRATqExcrxnuYhtaH6gSnOwB541hU/j12g5EmJy2mRTzi?=
 =?us-ascii?Q?zxjbOjUS+z1DTi1EHDp4/oCrRxdImYL8i5e9mRms04Q/iNG4GG7d1fNC0HDJ?=
 =?us-ascii?Q?FRCjm9xl5RdQba2/a3XACMw8xnmOO75ltbceuAYcnz/lyiLq71OJxdzGYaM/?=
 =?us-ascii?Q?U4EgH3wPQqnknw3oFmLcwHwLE1tp/oknA8R6plTSrtO8mC+sQfdDchycXINi?=
 =?us-ascii?Q?4xpCz2QqGlqLPczqo2OROfI8SDM9PXA3KFibiEitRWmbwCGXH3dPA1HztViU?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 635c6ba6-90a0-46e9-a9f9-08ddcb5dbfe0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:29:26.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP0u4jyRQbQjiUg+XaIT+0yCpnC3H01c81Ev4szvKKWuDnQIUILZUvu+9LVQhCsuIXLx5cJKGwfjw6yeWoQOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com



Hello,

we don't have enough knowledge how the issue is related with this change.
afer rebuilding kernel and rerunning tests, the issue is still persistent.

f7870e8d345cdabf 4edf1505b76d30e1e1e283d431e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20         100%          20:20    dmesg.assertion_failure

so we still make out this report FYI.


kernel test robot noticed "assertion_failure" on:

commit: 4edf1505b76d30e1e1e283d431e4f84ad01ddcef ("ata: ahci: Disallow LPM policy control for external ports")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 97987520025658f30bb787a99ffbd9bbff9ffc9d]

in testcase: igt
version: igt-x86_64-74f549981-1_20250719
with following parameters:

	group: group-12



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507251014.a5becc3b-lkp@intel.com


[   69.863206][  T491]
[   69.869866][  T493] grep: warning: ? at start of expression
[   69.871933][  T491] Opened device: /dev/dri/card0
[   69.873770][  T493]
[   69.879334][  T491]
[   69.881231][  T491] (i915_pm_rpm:1622) igt_pm-CRITICAL: Test assertion failure function __igt_pm_enable_sata_link_power_management, file ../lib/igt_pm.c:392:
[   69.884533][  T493] grep: warning: ? at start of expression
[   69.885396][ T1622] [IGT] i915_pm_rpm: exiting, ret=98
[   69.886239][  T491]
[   69.888431][  T493]
[   69.904183][  T491] (i915_pm_rpm:1622) igt_pm-CRITICAL: Failed assertion: write(fd, "min_powern", strlen("min_powern")) == strlen("min_powern")


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250725/202507251014.a5becc3b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

