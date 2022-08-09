Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F49C19F2D
	for <linux-ide@archiver.kernel.org>; Tue,  9 Aug 2022 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiHIO4A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Aug 2022 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiHIOz7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2022 10:55:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3B64DF
        for <linux-ide@vger.kernel.org>; Tue,  9 Aug 2022 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660056956; x=1691592956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/y03tk8Vi+r4ivUpOIzB1qW/+LcKMkgnnn79oUwijQA=;
  b=QaX8Y5wgvgho4K6ecAwaYs5Hd+7nHUeEomsnI3UcEdT6FhH8+SC/3pLe
   87BR9cJQUBaDe9fYgpzIH8XZU+yCS79M3pDvEoUli9cem6SCnBRgzRvdE
   qujcEyiy/6w54Qvfx0RyXjGstDldHCxX0BasOu7uc/PwiUV/PqI7Ix07k
   tI798S/3GwItVcQcFK/9382m+45+7gLY1nvati+85azVaAj9dweaFsZTC
   /Z1ATx4FERWMJegAmpwyXwrNdVM8UFBsDsNaL7eRNxdthWk2HSe1c8jTB
   1ZoIl8vR7WPP9O5adufow8vye8YGB9EZ1mNbx8dvV3lCF7uBbLVTbVPTv
   g==;
X-IronPort-AV: E=Sophos;i="5.93,224,1654531200"; 
   d="scan'208";a="206746656"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2022 22:55:55 +0800
IronPort-SDR: 2Quy4/jbnnOb76Uf0B1uYrQ/V3ymQ400Ru5Q87VtQUoDd1u+ax2D08jlThMnNGXJHr++/yDbci
 0RzlXCESIshb4zVrBQjV476nYCIg3RfqdJNEsI3A2GI8BrPPkq4NrNw4n7/dXmdWBi7I2+JH6W
 rR28EG8r1Crv26PkCaWy7237MazjlqyUeATkJEpA3FyuZ0xoywl/UhWnM7XriOAQipTJ/nVLmg
 hMfy5NcSxA8Ey6borgqSPcrjyniJ0Wgzz71EMvLNK69IlhR6utnszb3mD/r8p8KTBnXSEzyItA
 Zlla15Rsga9gimsBUzCEZ8E9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2022 07:11:35 -0700
IronPort-SDR: vp0sOP74wifDdBrEsQHC68uzz/bh/F9q01nV/i2N4RJVK6zHEjVT5E119LA3OW2EuU5XbuqPUj
 YcTfY5fMusAZupvVnX75qBa+gCdxdNbZCmRajgkz2KPkRGa8u5+Jw5D5ADJQ14z9Br2AiHGYKf
 KrcAjfL9NCwIQfWDSqf9jq+Ad5td7LkkgIUKPm93DDFy5qdD98v5+DvgOFJjBHJyrWiDyZKkLU
 KgFTwrGH1Y7pJGf9g3xJYv6XzymGYEGVR/fINz+znQgutJYf2RMHns8eUGo9OGOk4z0AZfH3Rp
 MCs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2022 07:55:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2GNC3qHMz1Rwnl
        for <linux-ide@vger.kernel.org>; Tue,  9 Aug 2022 07:55:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660056953; x=1662648954; bh=/y03tk8Vi+r4ivUpOIzB1qW/+LcKMkgnnn7
        9oUwijQA=; b=K0UAjEw7+GWiG/LXH6pGMRagU890IuIaNhlU9PRQYfh4jUuaktB
        bEAFg9jncr6SunBdEG8xmwm5r9CJnsgJQ/5fbG78uWfAqZ+yhS221Y0qOJWLzpJ9
        eppTPlxKAav9QGkk2nvEkr3zpSXGWkk9kDMznVA4rBcrJd8MwYNCT1ZZdJu6AAkX
        kMxcYCol8eEcyUHYLrk909iYbHzGXKla6H/oD0KDrimULuq3aXPAuUKZeKVCMEJP
        mp3YM2H1OTXiSowRkjwlwmzEAS8OBDLJ5t1vLlP3QX8hST/kfNK4t/GeFTZgIpFs
        UQSVHxn1+93+XDFFk0rko2RZLUNrGsR6JUg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wpffe584U-Dr for <linux-ide@vger.kernel.org>;
        Tue,  9 Aug 2022 07:55:53 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2GN94KBrz1RtVk;
        Tue,  9 Aug 2022 07:55:53 -0700 (PDT)
Message-ID: <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
Date:   Tue, 9 Aug 2022 07:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/09 2:58, John Garry wrote:
> On 08/08/2022 15:52, Damien Le Moal wrote:
>> On 2022/08/05 1:05, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per_se=
c due to commit:
>>>
>>>
>>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scsi: =
cap ata_device->max_sectors according to shost->max_sectors")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
>>>
>>> in testcase: stress-ng
>>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>>> with following parameters:
>>>
>>> 	nr_threads: 10%
>>> 	disk: 1HDD
>>> 	testtime: 60s
>>> 	fs: f2fs
>>> 	class: filesystem
>>> 	test: copy-file
>>> 	cpufreq_governor: performance
>>> 	ucode: 0xb000280
>>
>> Without knowing what the device adapter is, hard to say where the prob=
lem is. I
>> suspect that with the patch applied, we may be ending up with a small =
default
>> max_sectors value, causing overhead due to more commands than necessar=
y.
>>
>> Will check what I see with my test rig.
>=20
> As far as I can see, this patch should not make a difference unless the=
=20
> ATA shost driver is setting the max_sectors value unnecessarily low.

That is my hunch too, hence my question about which host driver is being =
used
for this test... That is not apparent from the problem report.

>=20
>>
>>>
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> Details are as below:
>>> ---------------------------------------------------------------------=
----------------------------->
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          sudo bin/lkp install job.yaml           # job file is attach=
ed in this email
>>>          bin/lkp split-job --compatible job.yaml # generate the yaml =
file for lkp run
>>>          sudo bin/lkp run generated-yaml-file
>>>
>>>          # if come across any failure that blocks the test,
>>>          # please remove ~/.lkp and /lkp dir to run from a clean stat=
e.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbo=
x_group/test/testcase/testtime/ucode:
>>>    filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian=
-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000280
>>>
>>> commit:
>>>    4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors accor=
ding to DMA optimal limit")
>>>    0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors accordi=
ng to shost->max_sectors")
>>>
>>> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0
>>> ---------------- ---------------------------
>>>           %stddev     %change         %stddev
>>>               \          |                \
>>>        1627           -14.9%       1385        stress-ng.copy-file.op=
s
>>>       27.01           -15.0%      22.96        stress-ng.copy-file.op=
s_per_sec
>>>     8935079           -11.9%    7870629        stress-ng.time.file_sy=
stem_outputs
>>>       14.88 =C2=B1  5%     -31.8%      10.14 =C2=B1  3%  stress-ng.ti=
me.percent_of_cpu_this_job_got
>>>       50912           -14.7%      43413        vmstat.io.bo
>>>       93.78            +1.4%      95.10        iostat.cpu.idle
>>>        3.89           -31.6%       2.66        iostat.cpu.iowait
>>>        4.01            -1.3        2.74        mpstat.cpu.all.iowait%
>>>        0.23 =C2=B1  9%      -0.1        0.17 =C2=B1 11%  mpstat.cpu.a=
ll.sys%
>>>        1.66 =C2=B1 37%      -1.2        0.51 =C2=B1 55%  perf-profile=
.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffered_w=
rite_iter.f2fs_file_write_iter.do_iter_readv_writev
>>>        1.66 =C2=B1 37%      -1.1        0.59 =C2=B1 25%  perf-profile=
.children.cycles-pp.f2fs_write_end
>>>        1.51 =C2=B1 40%      -1.1        0.45 =C2=B1 26%  perf-profile=
.children.cycles-pp.f2fs_dirty_data_folio
>>>        1.21 =C2=B1 49%      -1.0        0.23 =C2=B1 33%  perf-profile=
.children.cycles-pp.f2fs_update_dirty_folio
>>>        0.88 =C2=B1 56%      -0.8        0.04 =C2=B1111%  perf-profile=
.children.cycles-pp.native_queued_spin_lock_slowpath
>>>        0.14 =C2=B1 26%      +0.1        0.25 =C2=B1 28%  perf-profile=
.children.cycles-pp.page_cache_ra_unbounded
>>>        0.88 =C2=B1 56%      -0.8        0.04 =C2=B1112%  perf-profile=
.self.cycles-pp.native_queued_spin_lock_slowpath
>>>     3164876 =C2=B1  9%     -20.2%    2524713 =C2=B1  7%  perf-stat.i.=
cache-misses
>>>   4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-loads
>>>      313050 =C2=B1 10%     -18.4%     255410 =C2=B1  6%  perf-stat.i.=
node-loads
>>>      972573 =C2=B1  9%     -16.4%     812873 =C2=B1  6%  perf-stat.i.=
node-stores
>>>     3114748 =C2=B1  9%     -20.2%    2484807 =C2=B1  7%  perf-stat.ps=
.cache-misses
>>>   4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-load=
s
>>>      308178 =C2=B1 10%     -18.4%     251418 =C2=B1  6%  perf-stat.ps=
.node-loads
>>>      956996 =C2=B1  9%     -16.4%     799948 =C2=B1  6%  perf-stat.ps=
.node-stores
>>>      358486            -8.3%     328694        proc-vmstat.nr_active_=
file
>>>     1121620           -11.9%     987816        proc-vmstat.nr_dirtied
>>>      179906            -6.7%     167912        proc-vmstat.nr_dirty
>>>     1151201            -1.7%    1131322        proc-vmstat.nr_file_pa=
ges
>>>      100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_in=
active_file
>>>      846362           -14.6%     722471        proc-vmstat.nr_written
>>>      358486            -8.3%     328694        proc-vmstat.nr_zone_ac=
tive_file
>>>      100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_zo=
ne_inactive_file
>>>      180668            -6.8%     168456        proc-vmstat.nr_zone_wr=
ite_pending
>>>      556469            -3.5%     536985        proc-vmstat.pgactivate
>>>     3385454           -14.6%    2889953        proc-vmstat.pgpgout
>>>
>>>
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are =
provided
>>> for informational purposes only. Any difference in system hardware or=
 software
>>> design or configuration may affect actual performance.
>>>
>>>
>>
>>
>=20


--=20
Damien Le Moal
Western Digital Research
