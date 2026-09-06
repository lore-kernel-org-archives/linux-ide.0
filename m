Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF23168EE
	for <linux-ide@vger.kernel.org>; Sun,  6 Sep 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695299; cv=fail; b=eLC2jWQmfN/wULr3LlW/5n8VZuaZnaQDrnnxBqL5+1zo9FCPHxd3x+oapZrRrnlZj9+xfUFPqf+TnxYVPSLZaTGK73J/deTEE3EKHz6b0ow70+3n+qg20CC93jyvkYWDU0/DnH+fIDNk2eKJlV9ecJeY74UCnCoMBAvqFcAI1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695299; c=relaxed/simple;
	bh=3ZYklOJsu65C28BiSpmne8hmDe1medO2Pv7Fu8fUyAQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B8Y6ZT/YIVmw7NFT3KajiZ1ZzLbMOX6PFGkUaRuHSYQnULYU+PBQYsk6yjBUPQQOSGzeVufUIANfHNJ9Ak+pa53cXp+3tS7l8swP/3clVzxdYo8ehVCIRLA+WfeJaFVDmU7K4q5TnldwT4/sWRxfLtkL0zZlNaJGSdswEa/w7C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=m+uvY/08; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="m+uvY/08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXcdbvXOwvEL3ZDd2XJnrZJV9vb94OStgMA3RElM+QO3y5NH3Z3YKlSJMfgemxAlW77Fs4pllHoxFap6yyuNyxq5z2mE3WmGibCOHNNtuWH5FaRo+jwlgWSVDKOsuvv4CClsvlPBj6aSGlz7tdC68EFYgZNd9DP/pTHDvHsJq2pwSvIscXdtWvFuTTznxVY5Yj+znug7Af98oM09e3iGeAWF7YcUND1BjYrrLlV4AS55ESdd5+JCX68UmcvQZZd5MpfUgzR+XMHrNF9sRGhhm56b4QWAY/4rU3Ih+LMGIPNJZIvjTSqA2hWGXgJoAirlU53zrj6BcxuD69/XLa3Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrR4XygyT+2l8wlbClBfCSnkRvWzdBXcbbftCXs8Eow=;
 b=DTxmB8cavEHsY+CTAR6lyk1hUIMRZUxrkVwjQP85yNPjoGPaeMyp5XlAuSCIQbx6QiA2Jq/x84CMOLP8D6LqCV5wofP4nZLpJlakx5vsGHINcdHfDtXOnWXM4YpQa1wGcq4ECtAKrpgNWARZgiRKj3/OZqAsBkhLtxNeDZyTDTMEKMzckZka24LWFD4GW//3unX50S8CvIaodrWSi6qra0IPyZBbteQC6SGB7YxGcnOaQ9g3foGHLxqWIkDHXWwZIeIP9TVmKrDUSm/1ZdRgrGCWI9ODnXdCpF5ixE1nH+MpjkR72GdF9Cwno3ZdL7XCVapTniz7tLCV9+EeliMHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrR4XygyT+2l8wlbClBfCSnkRvWzdBXcbbftCXs8Eow=;
 b=m+uvY/083nKpDGYAvC3uNfwYgYCNrDOMWGj43JYzLdXVS7tshvK9KMm7QfMKZuGwXh1Vh9udVD3P0tiyh8NbAZpOKLLudeod3FsDQQw9ANU1YntqmzaQKor95eKu7SoYsd4jvxPr1TRSPYbWcCp0cRoq0HByVMo2ranH0LPyzpANYeXdmSUY/fKa2EHzIWWDj2mEUV8GC10Ju0QgAGXpmjzNVNIClhoP+0syN/k0wUo+e3TYyIUbcfRzYGZo3Uow2q2i7+/GZUeoBVWFEyRrczhWug9dyCS6Op5QvAxQg2BREGoD0aef41GzKfkyq+wC59mKElGxdhOrPH5286YUNw==
Received: from GV4P193MB2649.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28b::13)
 by DB8P193MB0487.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 11:48:14 +0000
Received: from GV4P193MB2649.EURP193.PROD.OUTLOOK.COM
 ([fe80::4dd5:52df:60fd:7c0f]) by GV4P193MB2649.EURP193.PROD.OUTLOOK.COM
 ([fe80::4dd5:52df:60fd:7c0f%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 11:48:13 +0000
From: snoep <snoepke@live.nl>
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Thread-Topic: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Thread-Index: AQHdPfUq2nUgAicd6UKaWT3J9EhUDA==
Date: Sun, 6 Sep 2026 11:48:13 +0000
Message-ID:
 <GV4P193MB26497ED32435527C96B10DB9A9B32@GV4P193MB2649.EURP193.PROD.OUTLOOK.COM>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4P193MB2649:EE_|DB8P193MB0487:EE_
x-ms-office365-filtering-correlation-id: 907d17f6-6c9c-4d64-ecb7-08df0c0cbbaf
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|12121999013|19110799012|24021099003|25010399006|13031999006|31061999003|15030799006|15080799012|51005399006|440099028|3412199025|26104999009|102099032|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZkU1HpZWjl2yHgwJlvXSSkoOQdbZ6c8IhkirXf1h3Cie3Nk+plqAPl85cR?=
 =?iso-8859-1?Q?hSWdpYtqADeRFhx3JA8P7aX4xkmvkmPfSZqsgrRuVjvkhVatNU5Zn1DAoj?=
 =?iso-8859-1?Q?gos7wL4+GDWyZq0Ok+ktJ6VT/6HV3/rIZTAqCkM7UUOK7Pcl8vbYuPqKEt?=
 =?iso-8859-1?Q?ht1MlEpK0PSSjmUafJN1ouIDi9X6tcjgwkINh4dOI3Qo3nrun4J0urVpaP?=
 =?iso-8859-1?Q?GDsBQJO7CAP04c0x6L/0YmPoJFONtauOEvp7wFQek1NwG2AxfRf77fo15i?=
 =?iso-8859-1?Q?Vbt1ccDzCf+v//bOBtSQuwNNeWDjjBhZksFKs8Mb9WQXJbfrp7l2Tzum7a?=
 =?iso-8859-1?Q?tEyaW23QVf2tnnBoBZLVuh0CvfVl2pwq5CjzL8an8eyDNAgz2f8hbaqsYW?=
 =?iso-8859-1?Q?KvHMx9ehJfp/MZ2HZATNC8iq1RaKjjEqVtJXP/nq/M3tFqzgJ3zLMzmBhO?=
 =?iso-8859-1?Q?p++42QFbExuqaqRm+qa48qmrYCkmPO0CwIhMoMno7vARufOq/G0Q5QmJ4X?=
 =?iso-8859-1?Q?krEilu5RhY8mnb/A3tnctq+S5TEGR0qhb4LnVpBfAfYtTnV8VdpUv+3EA7?=
 =?iso-8859-1?Q?M9PdI7vcb4MmhFy8vLQifd9ZFhNJVRO+HVM7G51Z5GsDN91xdtO+SnMxrx?=
 =?iso-8859-1?Q?p5DraK2RcYNDV0k2E2wwS6da6rkA2xRf/bGPemqV8UIO/Ou/6NCohGC3UO?=
 =?iso-8859-1?Q?DU6pcQdCBhrT9q8Ac0BR5ja02k5I2Ai7zDkOqE2Sh/OfYaiE28y8ExVH8+?=
 =?iso-8859-1?Q?bhY/9SeuIFfJPvZtMX5LNcKGJj6UcfBuVWAlGy4cbogiWUIcp9vUtnseNX?=
 =?iso-8859-1?Q?Blo4DAdMeu6ePJBE/hKGFIA2RtZWDK1cbw+8o5DlwXii2QNyQggVwm9ezj?=
 =?iso-8859-1?Q?HRMd+/yWl4Jq4MjHmhefzUfEfikKyneaeGN0qxEgLLeO7pGbDF0bPJobUP?=
 =?iso-8859-1?Q?6iwrc13feYAP9FIOXV9BJl+9dSGiw5NTFzrvhZwZOFLRSIJbQmrAF3PtdT?=
 =?iso-8859-1?Q?Oy+ivSf/TNwtx5fQ7iALg7N87rEJYZZGg2PpYNw+XRuPSkbkAc2w1C9SPE?=
 =?iso-8859-1?Q?Pw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zSVONvMFvrLq452V15M5COg791trql2j3RSBZ8Sp1ZKl4eGPJzlXK0F8J2?=
 =?iso-8859-1?Q?Np4Vy/J8dEmbDg2F4bvoBagt6Jkw8dHq2sWNDcssIUeOOuBMlrSP7RCB8P?=
 =?iso-8859-1?Q?ODRonngBJe3BcyX/EpYP8LSHlB9dh1VxVX0SZhZbQHFAyo6NencjOJcSZg?=
 =?iso-8859-1?Q?9mba4WLplj0zBoejaaRDkE6ni1m6/4M20Sldt5JT7CHhRHL64zSqMZBd75?=
 =?iso-8859-1?Q?JDVXGdqpksuxoFSRvpmD9XvUsXCGTX5DMWD1WBEOhE8zfi0WTKo0GIpSLC?=
 =?iso-8859-1?Q?rfUlhoRiDj9JuCnDV8NmtobecNfxUQuNGKVClmfc4gdSbvLnyaCLFLSx6S?=
 =?iso-8859-1?Q?NNTJbJ/dQfWkOMZ5kYp67Qw7FqyKnwhms6ej7tm224J269bVK/UmQ/lPAV?=
 =?iso-8859-1?Q?A0UI6Wdo+Ke+I51xjCqshQyWoqrsZAhKgatXgVYqT56pnDDjPWPCx6UiEy?=
 =?iso-8859-1?Q?bsQ510BJ5aalhLmTRp276UFhEg/tAqHeIT+UBUI/GkpHyPlNppi+YlTp9M?=
 =?iso-8859-1?Q?ddGWBtnbSl3Yu+3F2CDdvHcz7zHRhIdDlFHVrnqFVqV6o8+7F4VpCqaPn8?=
 =?iso-8859-1?Q?iEN26sCyMSv/gVAawLZ+5inKDIu4EBZs6utUk+wjmq9xic60htArDNq/Fq?=
 =?iso-8859-1?Q?BvsSRLJkxice1FysojSkrK2iWiq8ydb0+tuS7SIoZxJBwjsBetkZHPStcG?=
 =?iso-8859-1?Q?ZlUEBFQ4dF8P84ZDeEyOMqNFXOufXfsf4OtS76Kja2GXPaKXqI6Ren8+c1?=
 =?iso-8859-1?Q?p3TinqhyIMG0CanOq1U4NGWeYZQlI8EWbzyNDIDKeTO8AHQ2XL9qSXsIbF?=
 =?iso-8859-1?Q?tYPyn721Hysh0zJ34JDqY8xsOswf+kKv5mu3OFG+4HDRFMN+kst9wiaREa?=
 =?iso-8859-1?Q?hyY8p8fYRXVqs9cnKu8ZsDgODAXaQIJ6w0pOwtb/MBcqrx+SJMTlTsRfx9?=
 =?iso-8859-1?Q?NumyrWMp1NN2dJEmxzthNtiXvgHKORvq5DBd4FqGhYuI3kTms0wTXvqMLJ?=
 =?iso-8859-1?Q?n0EpEeLdETWkTZrtw36aJlmF1DtwqCflQHCFF3Mu6E7/lT1gOlHeKie7NU?=
 =?iso-8859-1?Q?FgLyvu/XpEh935oCLE1Ve1k0zrZ/CIAyz86PyU0gwRCPWerXYJUrr8JDrA?=
 =?iso-8859-1?Q?VaoVfg46Vb0/pawc661aINOTbGGzBjnVRw57yon+voUJAQSlPvQgIYhbc3?=
 =?iso-8859-1?Q?tOMpfo50mQrLMTGp8TNXuuSiDgHfg1crM6E/g2bQdNZ01LR49xXyyEsL6L?=
 =?iso-8859-1?Q?lccD8Hu9vGgRUXLXZZVLT5JmA3cEnWAAFng1L5BD9iHnBbzLYpMy32XIUd?=
 =?iso-8859-1?Q?pWfX3XwAgljxV+f703eXEsglN7ICuu6+Dd+Ee2uAEovaDtxbnH5NJJ1N6F?=
 =?iso-8859-1?Q?WW5W8tR0RjFJyJXbEYVXmrR4O6SIe5Iw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b2714.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4P193MB2649.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 907d17f6-6c9c-4d64-ecb7-08df0c0cbbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 11:48:13.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0487

Hi Niklas, all,=0A=
=0A=
I have an additional JMB585 data point from a Raspberry Pi 5.=0A=
=0A=
I ran Mikael's fio reproducer on a JMicron JMB585 (197b:0585).=0A=
There is one important limitation: the JMB585 on this Raspberry Pi 5=0A=
does not have an IOMMU group:=0A=
=0A=
  iommu_group: NONE=0A=
=0A=
Therefore this does not satisfy the specific request for a JMB582/JMB585=0A=
behind an Intel or ARM IOMMU in enforcing mode.=0A=
=0A=
I still hope the results are useful, because this same Raspberry Pi 5=0A=
and Penta SATA HAT setup previously showed repeated EXT4 metadata=0A=
corruption which I have not yet been able to explain.=0A=
=0A=
The previous investigation and actual filesystem errors are documented=0A=
here:=0A=
=0A=
Radxa forum:=0A=
https://forum.radxa.com/t/repeated-ext4-metadata-corruption-on-raspberry-pi=
-5-with-penta-sata-hat-jmb585-despite-healthy-ssds-and-raid1/31393/6=0A=
=0A=
Raspberry Pi forum:=0A=
https://forums.raspberrypi.com/viewtopic.php?p=3D2386959#p2386959=0A=
=0A=
The original corruption occurred on an EXT4 filesystem on Linux md RAID1.=
=0A=
SMART and SATA CRC counters were clean, the RAID1 remained healthy, and=0A=
for one known bad EXT4 directory block both physical RAID members returned=
=0A=
the same data.=0A=
=0A=
For this reproducer I used a single dedicated SSD behind the same JMB585.=
=0A=
=0A=
Test system:=0A=
=0A=
  Raspberry Pi 5, 8 GB=0A=
  JMicron JMB585, PCI ID 197b:0585=0A=
  Linux 6.18.34+rpt-rpi-2712=0A=
  fio 3.39=0A=
  Kingston SEDC500R960G=0A=
  AHCI driver=0A=
  PCIe Gen2=0A=
  io_uring=0A=
=0A=
The 256 GiB canary used:=0A=
=0A=
  bs=3D128k=0A=
  direct=3D1=0A=
  iodepth=3D32=0A=
  verify=3Dcrc32c=0A=
  verify_interval=3D4096=0A=
=0A=
Test 1: normal Raspberry Pi PCIe configuration / 64-bit DMA=0A=
=0A=
I did not enable:=0A=
=0A=
  dtoverlay=3Dpcie-32bit-dma-pi5=0A=
=0A=
Runtime state:=0A=
=0A=
  dma_mask_bits: 64=0A=
  consistent_dma_mask_bits: 64=0A=
  iommu_group: NONE=0A=
=0A=
AHCI reported:=0A=
=0A=
  flags: 64bit ncq sntf stag pm led clo pmp fbs pio slum part ccc apst boh=
=0A=
=0A=
I wrote the 256 GiB canary once and completed more than 20 full=0A=
verify-only passes, approximately 5 TiB of verified reads.=0A=
=0A=
No fio CRC32C verification failure occurred.=0A=
=0A=
SMART remained clean and there were no relevant ATA/AHCI/EXT4 errors=0A=
in the kernel log.=0A=
=0A=
Test 2: Raspberry Pi 32-bit PCIe DMA overlay=0A=
=0A=
I then enabled:=0A=
=0A=
  dtoverlay=3Dpcie-32bit-dma-pi5=0A=
=0A=
After reboot:=0A=
=0A=
  dma_mask_bits: 31=0A=
  consistent_dma_mask_bits: 31=0A=
  iommu_group: NONE=0A=
=0A=
I first verified the original 256 GiB canary written during the=0A=
64-bit DMA test. That complete verification passed.=0A=
=0A=
I then wrote a new 256 GiB canary with the 31-bit DMA mask active and=0A=
ran exactly 20 verify-only passes.=0A=
=0A=
Results:=0A=
=0A=
  original 64-bit-written canary cross-check: PASS=0A=
  new 32-bit canary write: PASS=0A=
  32-bit verify passes: 20/20 PASS=0A=
  reads during the automated 32-bit test: 5376 GiB=0A=
  writes during the automated 32-bit test: 256.02 GiB=0A=
=0A=
Final counters:=0A=
=0A=
  Raw_Read_Error_Rate: 0=0A=
  SATA_Phy_Error_Count: 0=0A=
  Reported_Uncorrect: 0=0A=
  Reallocated_Event_Count: 0=0A=
  SATA_CRC_Error_Count: 0=0A=
  CRC_Error_Count: 0=0A=
  Read_Fail_Count: 0=0A=
  Interface CRC Errors: 0=0A=
  Command failed due to ICRC error: 0=0A=
=0A=
So I was unable to reproduce the corruption on this Raspberry Pi 5=0A=
with either the normal 64-bit DMA configuration or the Raspberry Pi=0A=
32-bit PCIe DMA overlay.=0A=
=0A=
Again, since this JMB585 has no IOMMU group, I do not consider this a=0A=
test of the Intel/ARM IOMMU enforcing-mode case.=0A=
=0A=
However, I am still trying to determine what caused the repeated EXT4=0A=
metadata corruption in the original RAID1 setup, and I would appreciate=0A=
guidance on what would be most useful to test next.=0A=
=0A=
Would repeating a sustained checksumming workload with the original=0A=
two-SSD md RAID1 setup be useful, or is there another workload, tracing=0A=
option, kernel configuration or test that would better help distinguish=0A=
between the JMB585/PCIe path, md RAID1, EXT4, or another component?=0A=
=0A=
I have kept the test installation, both canary files and the complete=0A=
fio, SMART and kernel logs, so I can run additional tests if requested.=0A=
=0A=
Kind regards,=0A=
Sven=
