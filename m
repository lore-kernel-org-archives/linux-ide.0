From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 2/2] ahci: implement AHCI_HFLAG_NO_FPDMA_AA
 and update NV quirks
Date: Mon, 29 Mar 2010 16:20:33 -0400
Message-ID: <4BB10B91.7040206@garzik.org>
References: <4BB00337.1030302@kernel.org> <4BB00364.40701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:45878 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0C2UUg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 16:20:36 -0400
Received: by iwn12 with SMTP id 12so950532iwn.21
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 13:20:35 -0700 (PDT)
In-Reply-To: <4BB00364.40701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 03/28/2010 09:33 PM, Tejun Heo wrote:
> It turns out different generations of MCPs have differing quirks.
>
> * MCP 65-73 : FPDMA AA broken, lies about PMP support, forgets to rep=
ort NCQ
> * MCP 77-79 : FPDMA AA broken, lies about PMP support
> * MCP 89    : FPDMA AA broken
>
> Instead of turngin off FPDMA AA on all NVIDIAs, implement
> HFLAG_NO_FPDMA_AA, define additional board IDs and apply necessary
> quirks.
>
> This fixes bko#15481 and the list of quirks is verified by Peer Chen.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=3D15481
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Peer Chen<pchen@nvidia.com>
> ---
>   drivers/ata/ahci.c |   38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)

ACK in theory, but NAK due to failed build:


drivers/ata/ahci.c:137: error: =91AHCI_HFLAG_NO_FPDMA_AA=92 undeclared =
here=20
(not in a function)
drivers/ata/ahci.c: In function =91ahci_init_one=92:
drivers/ata/ahci.c:1128: error: invalid operands to binary & (have=20
=91unsigned int=92 and =91const struct ata_port_info *=92)

