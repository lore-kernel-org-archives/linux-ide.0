From: =?ISO-8859-15?Q?Kasimir_M=FCller?=
	<Kasimir.Mueller@med.uni-tuebingen.de>
Subject: libata Patches
Date: Mon, 11 Dec 2006 08:40:23 +0100
Message-ID: <457D0B67.6000406@med.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040600080604010508080108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from noir.zit.medizin.uni-tuebingen.de ([134.2.188.1]:57017 "EHLO
	noir.zit.medizin.uni-tuebingen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762644AbWLKHk3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 02:40:29 -0500
Received: from weleda.zit.med.uni-tuebingen.de (weleda.zit.med.uni-tuebingen.de [10.181.20.13])
	by noir.zit.medizin.uni-tuebingen.de (8.13.8/8.13.8) with ESMTP id kBB7eRqf011667
	for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 08:40:27 +0100 (MET)
Received: from esprit.zit.med.uni-tuebingen.de (esprit.zit.med.uni-tuebingen.de [192.168.29.45])
	by weleda.zit.med.uni-tuebingen.de (8.13.6/8.13.6) with ESMTP id kBB7eMJZ009914
	for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 08:40:22 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600080604010508080108
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tejun,
I have tested your patches with the vanilla 2.6.18.1 - Kernel and it works like a charm.
I have spent hours of copying, reading and deleting data to a software-raid-5 on a Machine with

Mainboard: Elitegroup K8T890-A
Prozessor: Athlon64
Addonics  5X1 eSATA Port Multiplier (PM) (AD5SAPM-E)
Addonics SATA-Controller PCIe-Card ADSA3GPX1-2E
System: openSuse 10.1

Because Suse uses a patched kernel
I cannot apply your patch to the standard-kernel from the openSUSE-Distribution.
As far as I can see (I'm not a programmer),
the driver-sources are already in the ata-directory of the kernel,
so the patch generates a lot of errors.

Could give any advice (on your wiki), how to deal with this ?


-- 
Dr.med. Kasimir Müller
Oberarzt
Tel.:  07071 - 29 - 86592
Funk : 151 - 8154

Klinik für Allgemeine, Viszeral-
u. Transplantationschirurgie
Hoppe-Seylerstr. 3
D-72076 Tübingen

--------------040600080604010508080108
Content-Type: text/x-vcard; charset=utf-8;
 name="Kasimir.Mueller.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Kasimir.Mueller.vcf"

begin:vcard
fn;quoted-printable:M=C3=BCller Kasimir
n;quoted-printable:M=C3=BCller;Kasimir
org;quoted-printable;quoted-printable:Uni T=C3=BCbingen;Klinik f=C3=BCr Allgemeine, Viszeral-,u. Transplantationschirurgie
adr;quoted-printable:;;Hoppe-Seyler-Str.3;T=C3=BCbingen;;72076;Germany
email;internet:Kasimir.Mueller@med.uni-tuebingen.de
title:Dr.med.
tel;work:86592
tel;pager:151-8154
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------040600080604010508080108--
