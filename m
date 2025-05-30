Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA476FB9;
	Fri, 30 May 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604508; cv=fail; b=ncoMhkisSgszQVgZnazm9yay23jnCTRuPl4LwiL4f00uvhLrSQVYtISSHK26dc0k077d0eVvAmMfBv/ap+uWOPm/v0YLn/cJtee4pR5VJ0HiZ+9jimGAkB7aH1eN+EV5GY7Yy2dEY1ziNnJixI4QrkVzvrMwAMDFU4Pu5yMxuTk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604508; c=relaxed/simple;
	bh=FvTjdfcQnwtfdpTUJmSO7eEk/pred02B6qwHRkKY0gQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y2XH5lXGh0p85q+dfCETFjb1cGNm5yQxUjdxeZlwjJG79if/sfAQ+1PiWcWSwSwD86p4qYjHKxgkAfha9K7/N2k51WgWvNoMDNTmCVHMRVbJC7Kah2tN8yHEbdZ6hX6osbRTT07Fuwt1i3sysxfCH10LpMF19jlrymZuJQcuCYY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wf6D8ktx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wf6D8ktx; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wf6D8ktx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wf6D8ktx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e4uJLnxpgmn2gxbKfeTe3fspYutROmkMRanMeBnyxZzHR7++/kksMCd8t0rNIqYP1P7yOv8JLCVJQmqOy9v3m5PrmvD/pT4sALCFS+qWUDNHy9LVAxJAgzV3XOAk8Y8+0HbtZLEJOjastsM9y1YbrGmYFGLZBTCoER2ViWQA4h7OBGYU6vgB/aI2TkL0HBrlyHZmTgTKjkqktVr6dZ7gQlXuaIzj/JOTEnTcDcJ1xliMpgiVSQmBv+Q3My1wjJnJMe02IvmyYMKFG5x3KdQN3xVgwF57OLGGeV86eyUsGphxiSiZrkTrYz8pWADp1w4A1037tStdgkKVz33vp+vE1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmT6HwdpKLCYj+WuClqG2+MPx8XoUvj7d7ntd6jNU+8=;
 b=Sb8od5ywBrWjhjV3xu9RLqyQOAmLWg4pCQlctK1s/y0BPFJGDEcsoDlH1PZ2hZk5hQScV9oWqy6VhnmwBdEAVqSVTXDl1uD59Ra5KwCsuXONgiRDmQ7ZfreI9rkcFN/cCNKfMLAfzvs7Qx4uvZlMPtXB6EGy34Ll3It6c9HXCu0c4FjLQL+dqDOmpu5uznYBIWkiHItPUN/EGR7Soyo2Jl621HVtXsHjHhGSclzQ8wogV2y32VN5fKaDrRcG3zJqoWvgJnbZfxNQVDUzSr3RGWKTvfyzocOM0ID2m6eWlg+p8iVYnAoPSmGjOB72dqmIriUSJb8Krn0pzmRoh4FyTQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sk.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmT6HwdpKLCYj+WuClqG2+MPx8XoUvj7d7ntd6jNU+8=;
 b=Wf6D8ktxGbvB8kim7fm5j7eVKcV8rN38sI0RoVTDnjbad10DNLUkV0VaudEtpZaY80L/tMv8WGRBjLZI/AMw1xZxLFScW+xMMofZ0pQB2mQKi5At2dhEQ69/iHAKFWlCw98I+BtJvQqlbAZGU1WLI1SGWIq9ZpglBnkDyKgPzdw=
Received: from AS9PR06CA0243.eurprd06.prod.outlook.com (2603:10a6:20b:45f::6)
 by AS1PR08MB7425.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 11:28:22 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::45) by AS9PR06CA0243.outlook.office365.com
 (2603:10a6:20b:45f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Fri,
 30 May 2025 11:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Fri, 30 May 2025 11:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWeHRIoT3orOhkHh1EgJ2OczhyATHcr6ORRYLAVoGUe2a0q7PdR5Nh+pvc+9LKr6opjiAOdwQuwi8h9jPqkaDXWIbmgJG59qqiP2/4sxwsneP+iHEP7TyigcX/hkCY7wamgxSgiSF0yjTNyO7SExRMv3I/kiAM5j78ia4aQrjZ8t7ZYlIhjeaWeOhPUigLNtlOHAhq0qeU2lu/9DQcnZiUONwaDcpY9fT//UYxpa1Jao5Vg8bLfAyan9ALHvIJYc4Rjo7VAyTsWoJQmPUl28ms6kF/6x1ERCC8wQ439b5duvZ+Bex7RTs9yitS+XEcJtt1AfwMNKdKekjpGauHhCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmT6HwdpKLCYj+WuClqG2+MPx8XoUvj7d7ntd6jNU+8=;
 b=nG8vSFgoOjk87gapwwxgGOSj4511k9LMXVb9GwR8vHuQd3X5tNbKDWgaTZD5cjko8KD80NmehIux1X6V9xSggn94ScAzdZiolIQlR0uage5zXruN1uX3UQWhMHJh8pTGooeOLDVD01cUOg5GoG7ipl01qJ/XrgoAcYU8dx9lgvS1YYjT/cPGYycn4rl+AfcJbi0ESlILTimLfka0zrOtxzOonbTpRlztDop6H+WgGwIIRrc1Xd504/8ugy989oaH5or5/R3FjS+wMZkIxSqadL/SjnKQolzps7avMMxZ0nPVxxc6Zxd+blySdqcq7sjNeCVPKBKjfHQOOQRX1lt0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmT6HwdpKLCYj+WuClqG2+MPx8XoUvj7d7ntd6jNU+8=;
 b=Wf6D8ktxGbvB8kim7fm5j7eVKcV8rN38sI0RoVTDnjbad10DNLUkV0VaudEtpZaY80L/tMv8WGRBjLZI/AMw1xZxLFScW+xMMofZ0pQB2mQKi5At2dhEQ69/iHAKFWlCw98I+BtJvQqlbAZGU1WLI1SGWIq9ZpglBnkDyKgPzdw=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8690.eurprd08.prod.outlook.com
 (2603:10a6:150:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:27:49 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 11:27:48 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Byungchul Park <byungchul@sk.com>
CC: "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"kernel-team@lge.com" <kernel-team@lge.com>, "open list:MEMORY MANAGEMENT"
	<linux-mm@kvack.org>, "harry.yoo@oracle.com" <harry.yoo@oracle.com>,
	"yskelg@gmail.com" <yskelg@gmail.com>, "her0gyugyu@gmail.com"
	<her0gyugyu@gmail.com>, "max.byungchul.park@gmail.com"
	<max.byungchul.park@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC DEPT v16] Question for dept.
Thread-Topic: [RFC DEPT v16] Question for dept.
Thread-Index: AQHb0U6pUB9ATSEvMUqnySF+e246bA==
Date: Fri, 30 May 2025 11:27:48 +0000
Message-ID:
 <GV1PR08MB10521BCB90DD275E324622DA0FB61A@GV1PR08MB10521.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8690:EE_|AMS0EPF000001B7:EE_|AS1PR08MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2946d0-f56c-4437-1a4e-08dd9f6d1578
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?e2daxSKR4d1Rla/LJezRwVVX3MQcpSuLYc/taEpG/hFZvXEaf0yYVnm7Mi?=
 =?iso-8859-1?Q?OMK8LvoBRYAEs/Of6Mh/iVbFO+bv0UUToIKmIHEwaAqM64FlkNpnCxhv/i?=
 =?iso-8859-1?Q?haAvO1B86x6McfcBJvUDcWp2TOiM2p5qnAB9Q3PNAV+3qhWRkk4BqA0839?=
 =?iso-8859-1?Q?XEBY63SV4+YZ7gn6Y8mjve8pcsrf1uZQLGGZvIAL4QgJ1flph4479NS8aT?=
 =?iso-8859-1?Q?oWKWqpJtwiUm/AJMbhTurn1C1RIIgvzdLiZdIuDeJi9XwdPjKG8SjdL3q8?=
 =?iso-8859-1?Q?uoPCkj+k3zlQl3Z5ZzdbYaO7VEmBFzeEnMKW2Q9C0T4nKD+/xAW6/aEZBA?=
 =?iso-8859-1?Q?AnL+W8wTZ+zr+BDtiQkDvhTyvS5KJZkxsW6AwdQ85gkeSC+54CcukEHvhK?=
 =?iso-8859-1?Q?p5Yeanr/wqrD2Ock3WszxE6igrMOekB75KjgdwIduGmomCxvFvrM4M6qQ6?=
 =?iso-8859-1?Q?FYPnSFasSu+fBZZOSYpSvvtURllKBrPfYhD3Zh6sJ4D+w0kHxjuxy/nYR/?=
 =?iso-8859-1?Q?G5sJMzpaFGOSpOO561/348GyTXv1cguSNPavf8gpS0gWZ5YAqNHazMMhm5?=
 =?iso-8859-1?Q?/E0T4yi7zdnY/vQ2f5G3ArfXgbk68QcuICisk4TSFZ5OipyBkLTPy4vyY2?=
 =?iso-8859-1?Q?oX7CxitfSMi/UPSqhFpdzxoxUyH7OnqEmEArUf84sQpzOTEPgxthyQ7PqD?=
 =?iso-8859-1?Q?zAT4JXAKhyId31xfzP33l36vMjJ4VXpHA4wXVhRhITw26hVkWdB177dzEW?=
 =?iso-8859-1?Q?RgTm0if055t1QYHZDbwbR5F9zStWSbyXj1H0ir0aTltW0l6PSxWD8+56HG?=
 =?iso-8859-1?Q?JYRfqFbm3B33fCsRf9iA9ss42g8RbRD0bsnlVai6OD64x6F2jDgXYyO+Nk?=
 =?iso-8859-1?Q?05G/nKIw2lQM3v3YCMHYemG/fp0iaVMm9Niu0G0EkVvJYfzRE5TRBrSWAs?=
 =?iso-8859-1?Q?ftVZPynIcauVmrUMmCvO8Hh0wdJZErmoBzx7CgXpUKTYNopUQIQXcL41Zs?=
 =?iso-8859-1?Q?RI0uKUnjClOmkya/3UNnkEP/2+kBtarNF+8ZDYRyyrq/WINBydek8w/v8Y?=
 =?iso-8859-1?Q?xzI7/Fas0osq1GxTJfSkKQmhMOgMrR7loD3bIWmuaTZUwp09AlPMeYij/C?=
 =?iso-8859-1?Q?aHq+ecsbYhk4EfUaT9WTrd2qZFKBoAdPLQ9KR6FOn6FOqnIlr8jIA9zfkP?=
 =?iso-8859-1?Q?+kigMtE3VQ+nOcagxSgbsDXyDJr5f3ZVKcqLJQtPRnfcy2mtuOpkvNBU4L?=
 =?iso-8859-1?Q?wE1+zdDJbf/JawHNmQo137twwViOZz9lPW6G7PHCqSnCXAioEWT9eFJlix?=
 =?iso-8859-1?Q?ulPzbfOX6gpo604IahI62SMuGrzPR3PVy+laL3QWJBTe+53BOAi9hzcESc?=
 =?iso-8859-1?Q?edvVrrZ/5hYAqaT2Vku+lYDy3F3jfZavtvhNh8TrhO7Kh5VtPYp3H6ADuc?=
 =?iso-8859-1?Q?kmk9tWQfIiy5nc5DpUZKnIchTpOEC+5FvD9pBZpiSi87ZI6dcOnPz4JKmZ?=
 =?iso-8859-1?Q?S7UWjslVf6XMF6HKy1oE6Cn3zb6FCh1yT8sz1H4ZiAZontoSQ7cZxS6Q+m?=
 =?iso-8859-1?Q?xEvzoIc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8690
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6dc2727-27fe-4d47-19b9-08dd9f6d01e7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|14060799003|7416014|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?znRRv3RhBdHIwMnworlVM+u1ZUNB+AyM+CHh6mAA3M0m/EnOm+TNFqCeqJ?=
 =?iso-8859-1?Q?UCjsnEa+p0QxIK+E3lkxCDiQya0340TCKFWEaQdan/UwSp6ukfoWnCnPxu?=
 =?iso-8859-1?Q?FdhpjrY6nGppDXaqiIMa00+3iKUiir6mC1fXjEm5MYn8AQUdf6B+ICdmko?=
 =?iso-8859-1?Q?kq3LeFiGaOZ3zTiiqmFQXLcwdt4MrOjOoYrOC6mnXhmc36xVtavGCzjLMI?=
 =?iso-8859-1?Q?C0nBJe+L5YzeAOymXktTTnRQVqAYCgGW86G2D3fgNFJKNyf1RlHFKRAZbD?=
 =?iso-8859-1?Q?7wIVHFycTKLuVHpQvimwuZjsTnTaFYz3pE4Ze6uup67poY0QZnACDC2+m0?=
 =?iso-8859-1?Q?jOaVW8m2qfDVTmVui64lE5wHKBrUugEZyzP4FkFjHo2pPkm7ntD1zEYsSH?=
 =?iso-8859-1?Q?QJR9nH0M2GXWgazguMstpzHPsArM+MI6LMa1drJ65ssVwUK47V7f2y+Mif?=
 =?iso-8859-1?Q?/33G81O/rbgR27s8jeHaWfbTRPTcGDthj+sBrwnZVym27Y4DTv3fAbVpEf?=
 =?iso-8859-1?Q?19aXFJK2oiDrkgwMWkqB1s9qEsNCI/5OsLMLq1lscgMVC1nyYL9pZlwImL?=
 =?iso-8859-1?Q?KK5zotA0lSp/wM+ZzvBRtoQguKkcI2vKpAsqgkGztnToVAxEJT6/Kp3E2L?=
 =?iso-8859-1?Q?FKxXaikMFbb5GlMAlbyGo6jGEqVtbGKyBJZvkkN8YfBg0g85c8mCJE42L9?=
 =?iso-8859-1?Q?xKXE1oOgOv7oYl/AQF9P53GC6Gje2ik1e7jAZeOGhDSHD2txIGgG2LuljN?=
 =?iso-8859-1?Q?1KftKLycv8KpoY+IMYCcyHpP1ktI5H28kcuvOCfeg0qx6/uzWeB3CMqvne?=
 =?iso-8859-1?Q?sk/sQ94/fGassSPJ8tDpoDqDzM/mln/+/arFTKqvZziJzwHiox4VsvoOBP?=
 =?iso-8859-1?Q?5UpMbC+aXrjfcK+1oIbyaefUORer++r5RBA0YW2eZxZBcczu+tXdtSq7KR?=
 =?iso-8859-1?Q?3Gpez83elFaQoLC7eBA2CWS+6JXeHuznryzhQGiryZfnVlDyGa+hsLtNt4?=
 =?iso-8859-1?Q?hBMMf5AXLvJMniITaPOSInJjQoc3qP/v4uoTJ/gZ3t3nnfPAfkw7IoUhuz?=
 =?iso-8859-1?Q?FDbO5bZFnKoEuGvNibtcWRcnjtV9qW7RePj2jlQqDVw/+hRZ1D/rTsRxm5?=
 =?iso-8859-1?Q?N5OCk7nWWjlcqTS1lGI0NRWIHumA+f+w+52THVdNET71bo3OJUZmAOfxk5?=
 =?iso-8859-1?Q?3NNTB1xlnw2B1cJsTaLXT5MfC6iQcVOYud3e2T3vZAEInPN0OG9JKMCMn6?=
 =?iso-8859-1?Q?V9r2eE5hizQcciaK4WOPW1pi72DM4SiVO9RD0JaqWQmjfBfcuy5MVNJGCM?=
 =?iso-8859-1?Q?7/exzBzqRi+lBS65KE+aQU43dpjEeyayQaymeFhGPAUrYb3duprC8XHr7A?=
 =?iso-8859-1?Q?k7D67OKZ0O97AGnWHAPfoP5y26bdPxmYOhtyKIGyi+Pbz+Ddg/DfDUfvOO?=
 =?iso-8859-1?Q?XFXzAKRheWlAMPlHOCK9JsniUzL2cbiIyHytyjeGjJGV2fKvEJp6UDxr3E?=
 =?iso-8859-1?Q?9i2wN60raLjNA8HbuDAh6GtjQR1uRKAteDp0jpNcnBBj5FauGSjioMRSjb?=
 =?iso-8859-1?Q?fCTIIuPLhqtWkr4DX8u+uv6dyvfK?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(14060799003)(7416014)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:28:21.6102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2946d0-f56c-4437-1a4e-08dd9f6d1578
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7425

Hi Byungchul,=0A=
=0A=
Thanks for your great work for the latest dept patch.=0A=
=0A=
But I have a some quetions with the below dept log supplied from =0A=
Yunseong Kim<yskelg@gmail.com>=0A=
=0A=
...=0A=
[13304.604203] context A=0A=
[13304.604209]    [S] lock(&uprobe->register_rwsem:0)=0A=
[13304.604217]    [W] __wait_rcu_gp(<sched>:0)=0A=
[13304.604226]    [E] unlock(&uprobe->register_rwsem:0)=0A=
[13304.604234]=0A=
[13304.604239] context B =0A=
[13304.604244]    [S] lock(event_mutex:0)=0A=
[13304.604252]    [W] lock(&uprobe->register_rwsem:0)=0A=
[13304.604261]    [E] unlock(event_mutex:0)=0A=
[13304.604269]=0A=
[13304.604274] context C=0A=
[13304.604279]    [S] lock(&ctx->mutex:0)=0A=
[13304.604287]    [W] lock(event_mutex:0)=0A=
[13304.604295]    [E] unlock(&ctx->mutex:0)=0A=
[13304.604303]=0A=
[13304.604308] context D=0A=
[13304.604313]    [S] lock(&sig->exec_update_lock:0)=0A=
[13304.604322]    [W] lock(&ctx->mutex:0)=0A=
[13304.604330]    [E] unlock(&sig->exec_update_lock:0)=0A=
[13304.604338]=0A=
[13304.604343] context E=0A=
[13304.604348]    [S] lock(&f->f_pos_lock:0)=0A=
[13304.604356]    [W] lock(&sig->exec_update_lock:0)=0A=
[13304.604365]    [E] unlock(&f->f_pos_lock:0)=0A=
[13304.604373]=0A=
[13304.604378] context F=0A=
[13304.604383]    [S] (unknown)(<sched>:0)=0A=
[13304.604391]    [W] lock(&f->f_pos_lock:0)=0A=
[13304.604399]    [E] try_to_wake_up(<sched>:0)=0A=
[13304.604408]=0A=
[13304.604413] context G=0A=
[13304.604418]    [S] lock(btrfs_trans_num_writers:0)=0A=
[13304.604427]    [W] btrfs_commit_transaction(<sched>:0)=0A=
[13304.604436]    [E] unlock(btrfs_trans_num_writers:0)=0A=
[13304.604445]=0A=
[13304.604449] context H=0A=
[13304.604455]    [S] (unknown)(<sched>:0)=0A=
[13304.604463]    [W] lock(btrfs_trans_num_writers:0)=0A=
[13304.604471]    [E] try_to_wake_up(<sched>:0)=0A=
[13304.604484] context I=0A=
[13304.604490]    [S] (unknown)(<sched>:0)=0A=
[13304.604498]    [W] synchronize_rcu_expedited_wait_once(<sched>:0)=0A=
[13304.604507]    --------------- >8 timeout ---------------=0A=
[13304.604527] context J=0A=
[13304.604533]    [S] (unknown)(<sched>:0)=0A=
[13304.604541]    [W] synchronize_rcu_expedited(<sched>:0)=0A=
[13304.604549]    [E] try_to_wake_up(<sched>:0)=0A=
=0A=
[end of circular]=0A=
...=0A=
=0A=
1. I wonder how context A could be printed with =0A=
    [13304.604217]    [W] __wait_rcu_gp(<sched>:0) =0A=
    since, the completion's dept map will be initailized with =0A=
       sdt_might_sleep_start_timeout((x)->dmap, -1L);=0A=
   =0A=
    I think last dept_task's stage_sched_map affects this wrong print.=0A=
    Should this be fixed with:=0A=
=0A=
 @@ -2713,6 +2713,7 @@ void dept_stage_wait(struct dept_map *m, struct dept=
_key *k,=0A=
        if (m) {=0A=
                dt->stage_m =3D *m;=0A=
                dt->stage_real_m =3D m;=0A=
+               dt->stage_sched_map =3D false;=0A=
=0A=
                /*=0A=
                 * Ensure dt->stage_m.keys !=3D NULL and it works with the=
=0A=
    =0A=
2. Whenever prints the dependency which initalized with sdt_might_sleep_sta=
rt_timeout() currently it prints=0A=
   (unknown)(<sched>:0) only.=0A=
   Would it much better to print task information? (pid, comm and other).  =
  =0A=
=0A=
Thanks.=
