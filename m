From: Tejun Heo <tj@kernel.org>
Subject: Re: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag
 them as removable" changes userspace behavior
Date: Sat, 27 Feb 2016 08:08:49 -0500
Message-ID: <20160227130849.GG3965@htj.duckdns.org>
References: <56CF35FA.1070500@redhat.com>
 <CAOLZvyG4JAdir0F1b2V==qdkM0+NvqxviQeqZ86t=0rbqys7oQ@mail.gmail.com>
 <56CFAF2E.4050001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CFAF2E.4050001@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Linux-IDE <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Feb 25, 2016 at 05:49:34PM -0800, Laura Abbott wrote:
> At least one user reported that this fixed the issue and he said
> you could add
> 
> Tested-by: Bob Schultz <bob@engineer.com>

Great, Manuel, can you please send a proper patch?

Thanks.

-- 
tejun
