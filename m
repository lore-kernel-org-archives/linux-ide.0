Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5947C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Feb 2022 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiBSCVV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:21:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiBSCVV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 21:21:21 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A51A76ED
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645237263; x=1676773263;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nQq6BP9IyFGZiASGjOpRWXdwNvB3iBh3wSyQ4poEMGg=;
  b=Ixa/f5CZ0Xn9a3ejtyfWGkuPtGCddVcszJ5DVQAISV0k68fXQD3zrfKv
   ZI8raE2FU/x9lDDNgU0XEm83PNoln45Rv9x1DAIKdCuR5610ouujYhCeS
   cQtaZHEfv3oqmhkdb4q5W316e3AUPqGCuXeYFjMVJ9fz/AY3ZVJyn3ANZ
   4UrmJmc7YEgPo3POakDERZTKHrxcttVBl3wZlzwCBJmfXBgB9AmMrZZ81
   xJzok8hychFrjvRTcbVagR2j9zSyQjD2oB7l/LJZf4RZl6AoFUArY6Bdn
   h44OCifTcQaXkOJ+t22TzVIb09tkR3VsDtFgDBYk9yEOLYl9PVnFWA4ea
   w==;
X-IronPort-AV: E=Sophos;i="5.88,380,1635177600"; 
   d="scan'208";a="193330302"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2022 10:21:02 +0800
IronPort-SDR: MFDAceE2gr6PkUvIVozeyGaIOs/tQfsfkfK1CGc8KX/ii9WCstHlqnTZaIbBCMeZr7PbGCpiqR
 ZfBC1wP/R84PTzLsjbOFedP6V40TW/UncwP8HW6Xq5bjjMJzZ8N2oqr6ooNEPbzfVEa+6jXrXK
 ya57SUeVYXJ44DsUeFU1HCWcz4NE6ex8XbeN7vGxXbCnTj79fSLymxn8ovWFJNXBnhxEZt1th9
 BT7YlOGQxznp+u7fiM3is9ddm4MYUWi5EScPGgJ2giI3fUnjXWlLRBCyaZeM3n9c7qLRA6uKsZ
 qLtsmdyzxa1TlVH4lklHkRJT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:52:40 -0800
IronPort-SDR: ZjC8tuF31g6y5H78Gzdv69dItPkf+lY/uZSDwO6CKxg8NlxvZrBLtGQtIu39RF1g00MuVzxof4
 DkOzt8esWg8JFZwvSdl0yjCg/nUSRqnEfb4R4X1vyy2TLtQPz/xFSCMPj9JI68fmh5krOkg4fk
 XqcDrHqyfTr3CTUJOSuklycTGny4kS35tv7pgx1ho3pJtLGR8RvqCYpBIaKyEfM19847Sp9jSX
 jNtXKzdAqng3AgOWo6rl9J1uheNOb3qIm918FHoPBiaIFEU4g5p3fWK8VbKWQ6TxVkO/gUsJvi
 A5A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 18:21:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K0sk65l2xz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 18:21:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645237262; x=1647829263; bh=nQq6BP9IyFGZiASGjOpRWXdwNvB3iBh3wSy
        Q4poEMGg=; b=URyUBfXXDhpNWm/U6ePa2Np9oYjelsRgdJC/GKf66pqY18tCaYz
        0td5HpjmNaJ9Z4xW+KSzqyJyc89fOD5n9BGNmaXkbWfM7+DFzdc7W5VYEw3dvmM5
        lLb5QJAJdFDDws/1hwecignkB9Yf4naQpyPzupW/ioEpaerRB7ipkgtEGwzkok/t
        phcbr54iyFzCCzrfZZWS46/dugjv9MDry7jx/WlqltCvX5p6vQG1jQw6wd+Rl8Gg
        QWK41qwD7A4UXIG5pd7UCdrspmXz4aY8cGkS8X0zFwfrAFZ4CfL1viR9l347DG+F
        +/SQ+K5QFx0dL9nE7NUQualEfRPb516ckjg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWgcQGCf0KKu for <linux-ide@vger.kernel.org>;
        Fri, 18 Feb 2022 18:21:02 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K0sk54jggz1Rvlx;
        Fri, 18 Feb 2022 18:21:01 -0800 (PST)
Message-ID: <1f706e66-10f2-6d63-d0fc-6930c175ff66@opensource.wdc.com>
Date:   Sat, 19 Feb 2022 11:21:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ata: add/use ata_taskfile::{error|status} fields
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8ecca7a5-1930-b2c5-d850-17caa4b95644@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8ecca7a5-1930-b2c5-d850-17caa4b95644@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/16/22 03:49, Sergey Shtylyov wrote:
> Add the explicit error and status register fields to 'struct ata_taskfile'
> using the anonymous *union*s ('struct ide_taskfile' had that for ages!) and
> update the libata taskfile code accordingly. There should be no object code
> changes resulting from that...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
