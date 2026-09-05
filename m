Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CC2E736F
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611216; cv=fail; b=RT7vXUK7zIXnKPkVcSqotbVqp3oYwscHGkkyPBDDi3rzFMdXKxRrBO0TCrbZSA9ghkoxVBqG2TvoIoEMCR3RkOfJZ143jSZlTtHXOSq7KKy+6Ta+1cMlJA5hG/kvR13oOFKFV15oD9vU9PHfWqm0zTH+lGVJAAgHhHBWCZBjU5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611216; c=relaxed/simple;
	bh=D67v62YCyr2Op5ka/mNpkCuUgxRs4ad6S71UNqskpGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gU+hswC9rVgApYEgzNNH7jag4+78wtnbMVg4gGwc4jT2Uf8h0ogEwDogRgVe624phlowv8RgAP8PokrbRlAbXAu435THToskzloPxK6TNIQlgdkOjwO14tZEZFuXmHaGMhQTxWWUk+yKDvtksc7Z7jkIdliDqnE5RJNJtGxKsXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=udEaOzvN; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="udEaOzvN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTR5C8MtP+u0N+9pPXtUe5MDRCxQ0kH6daCbMapMriebYfHlGziHOCoTNQ56M9XuCkBATCcB2sn3cl52/uyo4+5G0/7Oq6EpFxZHP24ufm8snTuitSkA+ojU0LIsFfszR/urVYQ7A4NEjrblnpDqBmFT689Sph5+3U6z+kzM3qtdSKynJMhcElGSDWSRn8tDFG3JnmJfddsaHyFOsyCCCMKChCUmaTEOBUKY6XxGQOSnC5UITm8cUTLex/SW1GJOcBKN5qRNgvrywF3FEsKTFAtxolRKDpZ98CLh4uFd0rYq1zQOvRqkJkIUnhvCZDLm5+HKYow+cgHSWbw1zdhXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdyphbsop5+49hIloiC2SP5fOGY5reLh/fsAopXUlYc=;
 b=c64khv2B31CLA5js7C1rM/XwrkV0eUST5nl81eDkBh2brnsxCA/LNF1GMd3E0f2zC0CDh7DeUYPS5NmqmlpVmuxsz4r8BiIsMqeEeP2BTQ1i88Gl54XJzzlxX0fnDcPBSqvAuq2aDik0T8d3tR0tOMxWefrYuyQjRknHRedYZKYdzobvQ6doySbFAweuGjUGb/CrvSMnvftFcWCbSWbPTyqxpZLi9SLxYX9OtZvA/E/9uJtowhhKyb6MPrypbykWPQG/JArM5/XARYs1XuB+djDHo8QH9MTE3eTjQsNdWnw/swC7S/utB2FOGzv78vk/YdzpZJDcPcS/nIxFU2PaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdyphbsop5+49hIloiC2SP5fOGY5reLh/fsAopXUlYc=;
 b=udEaOzvNqLKf3d3LTEvXeiiHdDQZ31+6SJlikf0LuD9TycRBqEt3SThzEBrKz6k7E1Oikzdaeig8ZR7nFmZStEqxMNoELU8IMyA9CamXGZ2qJZtZZz1qyvhUpwl9VLLOG4eF13LaVpaD5enjw90oVtK2mLHKH1lysk2B1Zf5ugo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS2PR12MB880722.namprd12.prod.outlook.com (2603:10b6:8:404::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 12:26:52 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 12:26:52 +0000
Message-ID: <1c3df04b-7929-4b43-adb7-6007347a954e@amd.com>
Date: Sat, 5 Sep 2026 07:26:49 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Alvin Lim <alvinwylim@gmail.com>, mikael1022bzh@gmail.com,
 cassel@kernel.org
Cc: roland.waltersson@netinsight.net, artmoty@gmail.com,
 linux-ide@vger.kernel.org, david.laight.linux@gmail.com,
 kernel@wantstofly.org
References: <178854093896.541085.18395405788748617410@gmail.com>
 <20260905113848.1397882-1-alvinwylim@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260905113848.1397882-1-alvinwylim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:408:fb::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS2PR12MB880722:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6207cf-4c81-403d-d734-08df0b48f6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|3023799007|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZuSCs2Ny1fGYSfZLknfjm3wCbwLroqp10t7+nHTr094lzCSDCJSKY7GjKzUDJLqkCm4CaGrl6sOtt2wOOeaXdtbTXYyAbV2Loshbql4lIZ5dryUL+X7Q2aMGfcS47GrSEPuNdMFBh5hIoE1YBWVMuYaY/5+Xc2kQMVKaVgv9sTXW0hnMoTOU+D7Io80dg/ziyAskvQOvbid6cs2cM/oX/BihgvKnBPBzgQOG6BKh4SF+mhn0yhweu2NqJr/eEd4zF7+S7fv9GlrzCL1+eJj0UWktLm38HHaDXdlX16w6EtM/QCaUbP1lq+Sv7gBnZb7LYVFDM3udFInHTBS2jDgmnyk+47aUpOFf0AwAs4iIASpvuE0PEYY+1JDdJmE/o6vZWGinFVOl+GOKPdUjs7SZtTdtyHi00n9I+gNKsR3tqKvkmELNI94Lr1mPCHTp+8EpFdDftpcen7jST6KSua8I4vc6A+FSvYG0rh/IdpZFY4gBRBCpJGBk97KuVJw38hLG6C1nNnT5jCUe7sWQHtBrESdatLqiSFtthXjPVZfCGkErpWNjpIMFWkKcuoR/0U7pOc0cq8kO7gCqvuBUEdOwZg/ijz1VlrBb1V8giYkvdCdynexfzY/uPH5EMBDHyO0m5Ab2emPTwhOB9+4sELsqFrN99n8PkxeiJQoXZ+dkMRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9YVEp6QmY2QTFCVy9uaVdFd2p3K1RWWVA2dVN0aFM0TGJPcHBsUnZueGpV?=
 =?utf-8?B?KzMyMzY2T2FZeHJ1bGJRWHJmcVFLbUhkRVpCMWREeVgzYnlZeGlaNjhrY1Rz?=
 =?utf-8?B?Qm9RWFhnbVIrdHphSzZLOTF4YmlmWTU5UGloRG9PRjZ0OHRvM0c0cXZ5bWRN?=
 =?utf-8?B?Tmw3Q1NlS25BWG5ZK0xvZXFRS2Z0dEtBZHpySW55ZDUrdVg4U1BjZW52MnlQ?=
 =?utf-8?B?RlhXYjRONnVNK005aWl1NndPa21YM1IrTW9DZGx5QzhRZDliK1NkY2syelRN?=
 =?utf-8?B?U3BKdmxTSjk0NDlnM3UzQ1ZPWDltcU5BeFc1aXBhZ0t6NG1RMHUvcnd0Tlp6?=
 =?utf-8?B?WVprekh5STNJaFV6SkFRVWNhYjlObWRCV2lSUFNkbUZEeENtVzI0QmhmTG5R?=
 =?utf-8?B?cXhoc3U3d3pPc2hnMkViQmlwR1QwWHl3MVc2TkkzR0oyWWYxOXFHZzFyRStD?=
 =?utf-8?B?Wk9wTDd3Y1VSTXZmZHplZE5kclFBdis2cUdJWERMT3Q0QmkvMFZzVEFUMVhK?=
 =?utf-8?B?SEcySWRLN1ZITGRCZGUrQUl5OHdjYWNrMXpkZTZBaE5oV2ZFYWtGS29sSVVl?=
 =?utf-8?B?UXJSU1lNWE4vUVU3ZTRTdWRaa0h5eVB1YkU1QlFnZUcrdW5QNS92elNxRnYz?=
 =?utf-8?B?bnBuZ1hIQnlwdU5jekR4SCtGeHE5eHpOVGFXcTBLbUsrNDVXeGpodDNlWEg0?=
 =?utf-8?B?SU1SaTFvT3h0MU9QQkhLaDVOeXNTbGxSRmw4WEE4TXpoRXlBMEJCSVIzZEVm?=
 =?utf-8?B?Ky9aOFhGMlZHQVRTTEpKQ2JsWjZpYVJPc0FObCt0MVhKZFpvZlhVTVhCWjRB?=
 =?utf-8?B?ME1DRWJnV2xjMXhSWmM4VUQyNDVwcnJHTGpwakpTcTRmcnBtdkhCREg2dmRJ?=
 =?utf-8?B?NERjSFQ1Sm9MTHVvUk9LLzBXOGVKT3Z4bUNwNU9tUWhpdXRDOVU5ZHpIR2c4?=
 =?utf-8?B?R1MyYzlGMmJjZzZ5SVBXaHFaejBOT0tjRDV2c3VsQ3pWOFVjQ0xaSytmUExZ?=
 =?utf-8?B?Ym5iRGFUTHdDeDkzTXhxT1d0dWd3U3UxZG9tcHNFQUhBMUpaVWdWb1RjNTZq?=
 =?utf-8?B?amdLV25BZWZnaHZBK29sSExNbk9jb1hMcVFETTZyYUNqSGhRcUtPSER2ZnR0?=
 =?utf-8?B?eVBtajFMVjJJbnRMMFM3TFd1dllNZDVnV1Nvem02c0FleUNEeVUya3U1L0Fh?=
 =?utf-8?B?NW51ejhrbVN0U2lld0RDdjgwWFZ3K0cvbGIzNWQxWUpuOGdTdjNpd3VoeVpS?=
 =?utf-8?B?MFZCb1RidDFHcjR3UVU2em9FV2JUc2QvMmNWR1pGZ054REVkRDNIWm5MeDlv?=
 =?utf-8?B?aDdEMHc5Z0tSTzNJRVVsbzNvOTlhb2NzVHRRcWJZdDBLOURUTkp1bGZRUmVh?=
 =?utf-8?B?Ry9ROWExOXJybFRzTmRKOFk0T0hmVTRpOXYyUWtYZUpyUEtRMnFxakxxQ1BD?=
 =?utf-8?B?WktHblJHTlRxT2N6eUc4SWlIcDhuR2diMkh3Z3l4d0JKeWRpVzhRNDg1eE15?=
 =?utf-8?B?UGY0aWMxRUNUeUFkclJaaUh1cS9RTjdCam5USEZLZm12ak1WSHVDanpIamdk?=
 =?utf-8?B?Sms2WktIOEJOZDlVNWJTWWY3QnI4YnlLeFdhTVJLaHZxU2R0aWFITDh1WHYx?=
 =?utf-8?B?MFc0ZlVHbnRBL3MzM1ZKSnB2R0lES0VCYUNwWklZeWVGMTU5RFVnVDBtMHBi?=
 =?utf-8?B?WjAxTVE4QlhnNmJycThXRDhIQTQwWWhSVkQrSHRONkg0SVNnckM4Z2Z6MDdB?=
 =?utf-8?B?TXVPdjZpN0dBVEUrV3h2NnoxZDBzcEUyNWVSdHliQmFrVWhqUWZoa2NVRUdM?=
 =?utf-8?B?aDl4SHZjVXJpTXdpbnFabXE3VVNHcUsralZRL0I1bURZTGtNK0RVYUJZZlpF?=
 =?utf-8?B?NHA0RW4xbm5kazlkWnRic1Blc1pCY01jMzcrQ3BjY0F1bk9EQnorNHVmNTN6?=
 =?utf-8?B?TFdFajFyd3BmM2lQNERxeUNNeDl1dXJEUjhzT0dUR29RbnlvOHdwN2I2TFcr?=
 =?utf-8?B?b0l5T0FKMHpDckRhTmt6U3BySjVSQk1wVFcxNjg0blpMWlBNdTc0ZWRKamFW?=
 =?utf-8?B?bUFsWFlYZ29Mc2liTnpaSzV2VjRKUzg5UWNwdWRLZjh6ai9BU3lvQWtFT1RZ?=
 =?utf-8?B?SlA1cTdIaFI0UlZ2SnZHNW5wM0FQWVBCYTRKRERxZ2ljTlA1Sm5rMHNuU3pN?=
 =?utf-8?B?TXh5VUkwWnRiV0x3VXB1ZVRWNHFpQk4zdXkvM3ZkbGc5ZWo2YzdNT3JMS0gw?=
 =?utf-8?B?UmQ1bGNjOXQ0QXlCT2o0UjlKb3prVEx1ZlIrWDk0Y0JMWW1FL0hkVU1xMmMr?=
 =?utf-8?B?QnRvNUpWQmZDNTNHZzVDeWhzMm1tdk9YbEF3Mk93SzhDL2FGRGhidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6207cf-4c81-403d-d734-08df0b48f6f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 12:26:52.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8ndN8dI1oULMsLhc3OzLmXPKbOFNRXE/dpYqqPxT7xXiBqFSIybop+v0/c8fd18LVVhmxwdQilvryCoQpxBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB880722

< snip >

> So: tell me which test would actually be useful and I will run it and
> report the result either way, including a negative one. I would rather
> spend the window on the question you want answered than guess at it.
> 
> Alvin Lim

Two things:

1. lspci -ttvvnn
2. Turn on  amd_smn_debugfs_enable=1 on kernel command line.
Then use debugfs to get me the outputs from the SMN reads of these 
registers:


        0x111401d0,
        0x111411d0,
        0x111421d0,
        0x111431d0,
        0x111441d0,
        0x112401d0,
        0x112411d0,
        0x112421d0,
        0x112431d0,
        0x112441d0,
        0x112451d0,
        0x113401d0,
        0x114401d0,

Something like this might work.

sudo bash <<'EOF'
set -euo pipefail

if ! mountpoint -q /sys/kernel/debug; then
     mount -t debugfs debugfs /sys/kernel/debug
fi

dir=/sys/kernel/debug/x86/amd_smn
test -d "$dir" || {
     echo "Missing $dir; verify CONFIG_DEBUG_FS and 
amd_smn_debugfs_enable=1"
     exit 1
}

addresses=(
     0x111401d0
     0x111411d0
     0x111421d0
     0x111431d0
     0x111441d0
     0x112401d0
     0x112411d0
     0x112421d0
     0x112431d0
     0x112441d0
     0x112451d0
     0x113401d0
     0x114401d0
)

printf '0\n' > "$dir/node"

for address in "${addresses[@]}"; do
     printf '%s\n' "$address" > "$dir/address"

     old=$(cat "$dir/value")
     [[ $old =~ ^0x[[:xdigit:]]{8}$ ]] || {
         echo "$address: invalid read: $old"
         exit 1
     }

     printf '%s: %s\n' "$address" "$old"
done
EOF
