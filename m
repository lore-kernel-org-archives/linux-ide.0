From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 12:54:34 +0100
Message-ID: <53049B7A.6080404@redhat.com>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140218233645.GP31892@mtj.dyndns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
List-Id: linux-ide@vger.kernel.org

Hi,

On 02/19/2014 12:36 AM, Tejun Heo wrote:
> On Mon, Feb 17, 2014 at 12:56:58PM +0000, Lee Jones wrote:
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: linux-ide@vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Please consider basing it on top of Hans' refactored ahci_platform.
> 
>  http://www.spinics.net/lists/linux-ide/msg47628.html

Which reminds I must test the version I've rebased on top of 3.14-rc1
and then send a v6 so that this can get merged.

Lee, I'll add you to the CC of the v6 I'm about to send.

Regards,

Hans
