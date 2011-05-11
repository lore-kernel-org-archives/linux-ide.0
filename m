From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: RE: New driver mtipx2xx submission
Date: Wed, 11 May 2011 11:40:56 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com><20110428230605.78c55c70@lxorguk.ukuu.org.uk><22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com> <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:29470 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab1EKRlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2011 13:41:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


> Elevator for flash devices should automatically be null and most of
the
> SCSI layer isn't actually used so it would be interesting to know for
> example what shows up in comparative profiles so that it can be
optimised
> or dropped out.

Here is the performance number from some experiments.

Test System : 
	Dell Power Edge R710 (1 x Quad core processor @3.20GHz) 
OS:
	RHEL (Enterprise) ver5.5 x64 (2.6.18-194.el5)
Test Software:
	Vdbench ver 5.02

These experiments were done by changing the queue depth in
vdbench(Q=xxx).

                        |------------------------------------|
                        | ahci   |  ahci | mtipx2xx| mtipx2xx|
                        | Q=256  |  Q=32 |  Q=32   |  Q=256  |
|------------------------------------------------------------|
|4k random read (IOPS)  | 15,831 |15,763 | 244,795 | 783,778 |
|4k random write (IOPS) |  4,058 | 4,072 |  46,696 | 135,864 |
|128k seq. read (MBps)  |  2,284 | 2,258 |   3,295 |   3,060 |
|128k seq. write (MBps) |  1,049 | 1,053 |   2,092 |   2,078 |
|------------------------------------------------------------|
