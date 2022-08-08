Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209CC00140
	for <linux-ide@archiver.kernel.org>; Mon,  8 Aug 2022 14:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiHHOwY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Aug 2022 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiHHOwX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2022 10:52:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56909627C
        for <linux-ide@vger.kernel.org>; Mon,  8 Aug 2022 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659970341; x=1691506341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+hRULVcsPThYGQGUyQjR2EoH2hAsR5uZetymktPaNSk=;
  b=meuyiGF9UglnGETG1q9KyfVZYook7IM8brbXiCjwtB66BiX820iC27OQ
   Kwz1fGKgXqqqrRZmKfz5mWRhFaj4QM/zA+2x+OVQn8S1rqxGNwm7wBEQu
   uC0ZXHR1zQO7/29OzlHT+oFCk7im74eEqteKrqfamKUDUBF1dORZAu7a2
   Jn7ra4CUdux/jlAj8y8Hy+a1gxFkvjvXXp7FmKhGve2n1wcACTzdBPxog
   IgVR9Pa6NxJ3AqKXlcJmVtoVbOv+MC5G4WSjodqWmoLmXVmEIfhxj5qlN
   O0L3adWOkfbXTKNPJzihj2T94j7oebc4i+P+yrjFWyiXXHA9AyGlpwTEE
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,222,1654531200"; 
   d="scan'208";a="213140935"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2022 22:52:21 +0800
IronPort-SDR: 982kcXOsfK/7qFntl3wnmfSwccaF8YGy8py5+SoTM2ERrKha1iknXZHSPNNVtiRh/fdLBP1YrD
 JTt3jR5QNPnbbFNqw5beokoQj6k9ii53KVc7ktZu03MWGzXH2Q76hdbAbkuYzopwcDWBxVIZY5
 HCLwOtSZLT5L27PxSueTAJFGCr1yw/k7nv2jawrp3opKigP6sJBwh32ppcZCyeVEw/UJWNIXLz
 Oq+s3gfmf8ROfQXTEbkAtS3W7DXxgJ0oqdUncccl4Q/a0PCodbBolJDodRDEo3Sa3kVf65kwRe
 xtgwXrH/SmNpSvrZqL0C5M23
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 07:13:19 -0700
IronPort-SDR: MOiu3xoFVaFAV2EU0/X53VVONX7PPUDsBlwNtcgE8YpU+FDE8rEupzFmgTtxAQdjca9FhDJJ4f
 Jzjk9ORP4DxUgT6aE0iEnC0fllCbbZ+xYifyvRjRvfDLiioAKf5a3DX992iqtjm8N/GpnxNJXT
 R5bMIyN+p7mnwabUXyDBrsUuKJVmCffMp1zK+2BLnaAKbWIMxvYMdIKwrd0fWlts1wGwBsrkEY
 gYKHv1wTbdbFAawy24iotb9UUWmI+Kr1bT87t+ks5vy33VM3bxOa3fOG4MgrImEFCaFhOMmRmq
 i5w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 07:52:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M1fLY2CX4z1Rw4L
        for <linux-ide@vger.kernel.org>; Mon,  8 Aug 2022 07:52:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659970340; x=1662562341; bh=+hRULVcsPThYGQGUyQjR2EoH2hAsR5uZety
        mktPaNSk=; b=QVLKnAqxbwUeq6XlSWeaXPa/Fs4gW9h/Dit3SeZb35umTxLKy5E
        71/PeWsN98be+qMKto826NzfTOXOg+qf011HDIrKNyszTQxxBWTpipSsaJgSv03E
        VX0/dclLGEvK/EkP27/rlcZuuWjdPiOw9MlYCumldyTaQIFBEZro9RtYXcO+wrL2
        ZBSMXogdmuwIz32ZzDmoMffoeInHAd9PEymCz7NDOO4rOepwLUH86FQVgthmcEUt
        BcKO879XXWh95jOj6662SfuVw1NG/bA4UbdFk0J6J2EMnejEU9lBjS5Xefz3/RJJ
        rlNjQFtftgmzdxZ7QBQhumpO1FuyMnNv2hA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TTtuigq5o6Eu for <linux-ide@vger.kernel.org>;
        Mon,  8 Aug 2022 07:52:20 -0700 (PDT)
Received: from [10.225.89.57] (gns5353.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M1fLW15Dyz1RtVk;
        Mon,  8 Aug 2022 07:52:18 -0700 (PDT)
Message-ID: <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
Date:   Mon, 8 Aug 2022 07:52:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/05 1:05, kernel test robot wrote:
>=20
>=20
> Greeting,
>=20
> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per_sec =
due to commit:
>=20
>=20
> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scsi: ca=
p ata_device->max_sectors according to shost->max_sectors")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> with following parameters:
>=20
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: f2fs
> 	class: filesystem
> 	test: copy-file
> 	cpufreq_governor: performance
> 	ucode: 0xb000280

Without knowing what the device adapter is, hard to say where the problem=
 is. I
suspect that with the patch applied, we may be ending up with a small def=
ault
max_sectors value, causing overhead due to more commands than necessary.

Will check what I see with my test rig.

>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> Details are as below:
> -----------------------------------------------------------------------=
--------------------------->
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached =
in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_=
group/test/testcase/testtime/ucode:
>   filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian-11=
.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000280
>=20
> commit:=20
>   4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors accordin=
g to DMA optimal limit")
>   0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according =
to shost->max_sectors")
>=20
> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>       1627           -14.9%       1385        stress-ng.copy-file.ops
>      27.01           -15.0%      22.96        stress-ng.copy-file.ops_p=
er_sec
>    8935079           -11.9%    7870629        stress-ng.time.file_syste=
m_outputs
>      14.88 =C2=B1  5%     -31.8%      10.14 =C2=B1  3%  stress-ng.time.=
percent_of_cpu_this_job_got
>      50912           -14.7%      43413        vmstat.io.bo
>      93.78            +1.4%      95.10        iostat.cpu.idle
>       3.89           -31.6%       2.66        iostat.cpu.iowait
>       4.01            -1.3        2.74        mpstat.cpu.all.iowait%
>       0.23 =C2=B1  9%      -0.1        0.17 =C2=B1 11%  mpstat.cpu.all.=
sys%
>       1.66 =C2=B1 37%      -1.2        0.51 =C2=B1 55%  perf-profile.ca=
lltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffered_writ=
e_iter.f2fs_file_write_iter.do_iter_readv_writev
>       1.66 =C2=B1 37%      -1.1        0.59 =C2=B1 25%  perf-profile.ch=
ildren.cycles-pp.f2fs_write_end
>       1.51 =C2=B1 40%      -1.1        0.45 =C2=B1 26%  perf-profile.ch=
ildren.cycles-pp.f2fs_dirty_data_folio
>       1.21 =C2=B1 49%      -1.0        0.23 =C2=B1 33%  perf-profile.ch=
ildren.cycles-pp.f2fs_update_dirty_folio
>       0.88 =C2=B1 56%      -0.8        0.04 =C2=B1111%  perf-profile.ch=
ildren.cycles-pp.native_queued_spin_lock_slowpath
>       0.14 =C2=B1 26%      +0.1        0.25 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.page_cache_ra_unbounded
>       0.88 =C2=B1 56%      -0.8        0.04 =C2=B1112%  perf-profile.se=
lf.cycles-pp.native_queued_spin_lock_slowpath
>    3164876 =C2=B1  9%     -20.2%    2524713 =C2=B1  7%  perf-stat.i.cac=
he-misses
>  4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-loads
>     313050 =C2=B1 10%     -18.4%     255410 =C2=B1  6%  perf-stat.i.nod=
e-loads
>     972573 =C2=B1  9%     -16.4%     812873 =C2=B1  6%  perf-stat.i.nod=
e-stores
>    3114748 =C2=B1  9%     -20.2%    2484807 =C2=B1  7%  perf-stat.ps.ca=
che-misses
>  4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-loads
>     308178 =C2=B1 10%     -18.4%     251418 =C2=B1  6%  perf-stat.ps.no=
de-loads
>     956996 =C2=B1  9%     -16.4%     799948 =C2=B1  6%  perf-stat.ps.no=
de-stores
>     358486            -8.3%     328694        proc-vmstat.nr_active_fil=
e
>    1121620           -11.9%     987816        proc-vmstat.nr_dirtied
>     179906            -6.7%     167912        proc-vmstat.nr_dirty
>    1151201            -1.7%    1131322        proc-vmstat.nr_file_pages
>     100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_inact=
ive_file
>     846362           -14.6%     722471        proc-vmstat.nr_written
>     358486            -8.3%     328694        proc-vmstat.nr_zone_activ=
e_file
>     100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_zone_=
inactive_file
>     180668            -6.8%     168456        proc-vmstat.nr_zone_write=
_pending
>     556469            -3.5%     536985        proc-vmstat.pgactivate
>    3385454           -14.6%    2889953        proc-vmstat.pgpgout
>=20
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are pr=
ovided
> for informational purposes only. Any difference in system hardware or s=
oftware
> design or configuration may affect actual performance.
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
