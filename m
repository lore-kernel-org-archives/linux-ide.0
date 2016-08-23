From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Tue, 23 Aug 2016 01:11:20 -0500
Message-ID: <CAJVOszCU63Dahdu6ZoKGgbWwwma=Mq5zji4j8ya=57NCwFUB_w@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com>
 <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
 <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
 <CAJVOszAHcuyLoSJwmKvK5vgM8aLqfQJsaw=Vx7K66wMEaqmu_A@mail.gmail.com>
 <CAGnHSEm5Ur-7eCj-_mJsTeDwxhkGHPERAodebDS7rRg0AvGn3Q@mail.gmail.com>
 <CAJVOszC_MfPtGTR05p=qSHjY_wu4ziMMAqgra7Pu0tQYoxa-Kg@mail.gmail.com> <CAGnHSEmLq0qcg8_LZBCqFYJohZORBSe58SSjC3sK7cCf=0g9EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:38726 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755695AbcHWGLn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 02:11:43 -0400
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7N60GAL033019
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 02:11:42 -0400
Received: from mail-yb0-f198.google.com (mail-yb0-f198.google.com [209.85.213.198])
        by mx0a-00003501.pphosted.com with ESMTP id 250fmf8hs1-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2016 02:11:42 -0400
Received: by mail-yb0-f198.google.com with SMTP id f60so103957550ybi.3
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 23:11:41 -0700 (PDT)
In-Reply-To: <CAGnHSEmLq0qcg8_LZBCqFYJohZORBSe58SSjC3sK7cCf=0g9EQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Tue, Aug 23, 2016 at 12:55 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> I am really not going to tell the whole story here again. We have a
> really long discussion on whether we should advertise Maximum Write
> Same Length for SCT Write Same, and the value we should advertise.
> (Didn't we come to an conclusion on that as well?)

I had thought the conclusion was leave b0 as is and let the WS10 limit
take effect per Martin.
-- 
Shaun Tancheff
