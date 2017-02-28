From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: WARNING in ata_sff_qc_issue
Date: Tue, 28 Feb 2017 14:23:05 -0500
Message-ID: <20170228192305.GI15287@htj.duckdns.org>
References: <CACT4Y+bXkvevNZU8uP6X0QVqsj6wNoUA_1exfTSOzc+SmUtMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+bXkvevNZU8uP6X0QVqsj6wNoUA_1exfTSOzc+SmUtMOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Feb 28, 2017 at 03:33:48PM +0100, Dmitry Vyukov wrote:
> If the WARNING is merely to inform user about invalid protocol, please
> issue a single line pr_err without the stack trace (invalid protocol
> value may be more interesting).

Yeah, the warning is harmless.  The code was written before
passthrough support and just assumed that nobody higher up in the
stack should be issuing unsupported protocols and warned on such cases
as a precaution.  I'm just gonna drop the WARN.  The error code to sg
command should be enough to indicate the failure.

Thanks.

-- 
tejun
